//
//  ViewController.swift
//  NASA-Photos
//
//  Created by gandrey on 05/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import UIKit

struct WorkDate {
    var date: Date
    var query: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return  formatter.string(from: date)
    }
    var label: String  {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return  formatter.string(from: date)
    }
    
    mutating func incDay() {
        self.date =  self.date + (60*60*24)
    }
    
    mutating func decDay() {
        self.date =  self.date - (60*60*24)
    }
}
    
class ViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var ystdButton: UIButton!
    @IBOutlet weak var tmrrButton: UIButton!
    
    
    var curDate = Data()
    var workDate = WorkDate(date: Date())
   
    
    var photoInfo: PhotoInfo? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        print(#function, #line, "Current date: ", workDate.query)
        
        descriptionView.delegate = self
        Networking.shared.fetchPhotoInfo { self.photoInfo = $0 }
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector (self.handleSwipe(sender:)))
        rightSwipe.direction = .right
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector (self.handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        imageView.addGestureRecognizer(rightSwipe)
        imageView.addGestureRecognizer(leftSwipe)
        
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer?) {
     
        let calendar = Calendar.current
        let datetoday = Date()
        let diffInDays = calendar.dateComponents([.day], from: workDate.date, to: datetoday).day ?? 0
       
        print( #function, #line, datetoday)
        print("Difference in days: ", diffInDays)

        if let handleSwipe = sender {
            switch handleSwipe.direction {
            case .left:
                if diffInDays > 0 {
                    workDate.incDay()
                }
                print(#function, #line, "Left - work date", workDate.query)

        
            case .right:
                
                workDate.decDay()
                print(#function, #line, "Righr - work date", workDate.query)


            default:
                break
            }
        }
    }
    
    
    func updateUI() {
        Networking.shared.fetchImage(url: photoInfo?.url) { image in
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
        
        DispatchQueue.main.async {
            self.dateLabel.text = "Фотография \(self.workDate.label)"
            self.titleLabel.text = self.photoInfo?.title
            self.descriptionView.text = self.photoInfo?.description
            //            self.descriptionView.
            let cprght = self.photoInfo?.copyright
            
            if cprght != nil {
                self.copyrightLabel.textColor = .black
                self.copyrightLabel.text = cprght
            } else {
                self.copyrightLabel.textColor = .gray
                self.copyrightLabel.text = "Copyright information is unavailable"
            }
            
        }
    }
    
    
    
}




