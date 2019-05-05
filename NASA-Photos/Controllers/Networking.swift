//
//  Networking.swift
//  NASA-Photos
//
//  Created by gandrey on 05/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import UIKit
 
class Networking {
    
    static let shared = Networking()
    
    private init() {}
    
    let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    
    func fetchPhotoInfo(workdate: WorkDate, completion:  @escaping (PhotoInfo?) -> Void) {
        
        let query = [
            "api_key":"bAc4m0X4hI1WZG2Z9Hevgxev4Drs75hRRMGjdUCt",
            "date": workdate.query
        ]
        
        let url = baseURL.withQueries(query)!
        
        print(Data(), #function, #line, url.absoluteURL)
        
        URLSession.shared.dataTask(with: url) { data,response, error in
            
            guard let data = data else {
                if  let error  = error { print(#function, #line, error.localizedDescription) }
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            guard let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) else {
                
                print(Data(), #function, #line, "Can't decode \(data)")
                completion(nil)
                return
            }
            
            completion(photoInfo)
            
        }.resume()
    }
    
    
    func fetchImage(url: URL?, completion: @escaping (UIImage?) -> Void ) {
        
        guard let url = url else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
            }.resume()
        
    }
    
}

