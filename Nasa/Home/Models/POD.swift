//
//  POD.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation

struct POD: Codable {
    let date: String?
    let explanation: String?
    let mediaType: String?
    let title: String?
    let url: String?
    let mediaData: String?
    let isLocalData: Bool?
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case date
        case explanation
        case title
        case url
        case mediaData
        case isLocalData
    }
}

