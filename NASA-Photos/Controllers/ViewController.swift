//
//  ViewController.swift
//  NASA-Photos
//
//  Created by gandrey on 05/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var copyrightLabel: UILabel!
    
    @IBOutlet weak var ystdButton: UIButton!
    
    @IBOutlet weak var tmrrButton: UIButton!
    
    
    
    var photoInfo: PhotoInfo? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        descriptionView.delegate = self
        Networking.shared.fetchPhotoInfo { self.photoInfo = $0 }
        
    }
    
    func updateUI() {
        Networking.shared.fetchImage(url: photoInfo?.url) { image in
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
        
        DispatchQueue.main.async {
            self.titleLabel.text = self.photoInfo?.title
            self.descriptionView.text = self.photoInfo?.description
            //            self.descriptionView.
            let cprght = self.photoInfo?.copyright
            
            if cprght != nil {
                self.copyrightLabel.textColor = .black
                self.copyrightLabel.text = cprght
            }
            
        }
    }
    
    
    
}




