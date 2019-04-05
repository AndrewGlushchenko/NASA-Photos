//
//  ViewController.swift
//  NASA-Photos
//
//  Created by gandrey on 05/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import UIKit





class ViewController: UIViewController {

    var photoInfo: PhotoInfo? {
        didSet {
            print(Date(), #function, #line, photoInfo ?? "nil")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.shared.fetchPhotoInfo { self.photoInfo = $0 }
        
    }
}




