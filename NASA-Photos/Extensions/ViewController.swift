//
//  ViewController.swift
//  NASA-Photos
//
//  Created by gandrey on 05/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    
    let query = [
        "api_key": "DEMO_KEY",
        "date": "2019-03-29"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(#function, error.localizedDescription )
                }
                return
            }
            
            let string = String(data: data, encoding: .utf8) ?? "nil"
            
            print(Date(), #function, #line, data)
            print(string)
        }
        
        task.resume()
        
        print(Date(), #function, #line)
    }


}



extension URL {
    
    func withQueries(_ queries:[String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
        
    }
    
}
