//
//  Urls.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation
import Foundation

enum ServiceConstants {
    static let baseURL = "https://api.nasa.gov/planetary"
    static let pod = "apod"
    static let token = "?api_key=dcEpgrtcQSsMrZDaNXJ8xdNBoK931OJPGY5eAbSE"
}

enum Messages{
    static let loading = "Loading...."
    static let error = "Error"
    static let noFavourite = "No favourites found."
}
