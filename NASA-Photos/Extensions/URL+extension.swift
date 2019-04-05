//
//  URL+extension.swift
//  NASA-Photos
//
//  Created by gandrey on 05/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import Foundation


extension URL {
    
    func withQueries(_ queries:[String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
        
    }
    
}
