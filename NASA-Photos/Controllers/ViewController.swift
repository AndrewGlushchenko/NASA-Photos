//
//  ViewController.swift
//  NASA-Photos
//
//  Created by gandrey on 05/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import UIKit

    
class ViewController: UIViewController, UITextViewDelegate {

    var workDate = WorkDate()
    
    
    var photoInfo: PhotoInfo? {
        didSet {
            updateUI()
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var ystdButton: UIButton!
    @IBOutlet weak var tmrrButton: UIButton!
    @IBOutlet weak var topStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        descriptionView.delegate = self
        
        Networking.shared.fetchPhotoInfo(workdate: workDate) { self.photoInfo = $0 }
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector (self.handleSwipe(sender:)))
        rightSwipe.direction = .right
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector (self.handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        imageView.addGestureRecognizer(rightSwipe)
        imageView.addGestureRecognizer(leftSwipe)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        topStackView.axis = size.width < size.height ? .vertical : .horizontal
    
    }
    
    
    @IBAction func ystdButtonPress(_ sender: UIButton) {
        
        workDate.decDay()
        if  tmrrButton.isEnabled == false { tmrrButton.isEnabled = true }
        print(#function, #line, "Righr - work date", workDate.query)
        Networking.shared.fetchPhotoInfo(workdate: workDate) { self.photoInfo = $0 }
      
    }
    
    
    @IBAction func tmrrButtonPress(_ sender: UIButton) {

        if workDate.incDay() {
            print(#function, #line, "Left - work date", workDate.query)
            Networking.shared.fetchPhotoInfo(workdate: workDate) { self.photoInfo = $0 }
        }
         
        if workDate.query ==  workDate.currdate {
            tmrrButton.isEnabled = false
        }
        
    }
    
    
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer?) {
 
        if let handleSwipe = sender {
            switch handleSwipe.direction {
            case .left:
                
                if workDate.incDay() {
                    print(#function, #line, "Left - work date", workDate.query)
                    Networking.shared.fetchPhotoInfo(workdate: workDate) { self.photoInfo = $0 }
                }
                if workDate.query ==  workDate.currdate {
                    tmrrButton.isEnabled = false
                }
                
            case .right:
                
                workDate.decDay()
                if  tmrrButton.isEnabled == false { tmrrButton.isEnabled = true }
                print(#function, #line, "Righr - work date", workDate.query)
                Networking.shared.fetchPhotoInfo(workdate: workDate) { self.photoInfo = $0 }

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
            self.dateLabel.text = "Фото \(self.workDate.label)"
            self.titleLabel.text = self.photoInfo?.title
            self.descriptionView.text = self.photoInfo?.description
            //            self.descriptionView.
          
            let cprght = self.photoInfo?.copyright
            
            if cprght != nil {
                self.copyrightLabel.textColor = .black
                self.copyrightLabel.text = "Copyright by \(cprght!)"
            } else {
                self.copyrightLabel.textColor = .gray
                self.copyrightLabel.text = "Copyright information is unavailable"
            }
        }
    }
}
