//
//  Date.swift
//  Nasa
//
//  Created by vikram on 01/08/22.
//

import Foundation

extension Date{
    func string(formate:String = "yyyy-MM-dd") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
}
