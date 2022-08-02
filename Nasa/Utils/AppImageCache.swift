//
//  AppImageCache.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation
class AppImageCache{
    let imageCache = NSCache<NSString, AnyObject>()
    static let shared = AppImageCache()
    
    private init(){
        
    }
    
}
