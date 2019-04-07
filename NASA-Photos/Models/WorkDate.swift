//
//  WorkDate.swift
//  NASA-Photos
//
//  Created by gandrey on 07/04/2019.
//  Copyright © 2019 GlAndrey. All rights reserved.
//

import Foundation



struct WorkDate {
    
    let datetoday = Date()
    
    var currdate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return  formatter.string(from: datetoday)
    }
    
    var date = Date()
    
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
    
    mutating func incDay() -> Bool {
        
        let diffInDays = Calendar.current.dateComponents([.day], from: self.date, to: self.datetoday).day ?? 0
        
        if diffInDays > 0 {
            self.date = self.date + (60*60*24)
            return true
        } else {
            return false
        }
    }
    
    mutating func decDay() {
        self.date =  self.date - (60*60*24)
    }
}
