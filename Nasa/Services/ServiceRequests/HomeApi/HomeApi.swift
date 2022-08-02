//
//  HomeApi.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation

struct HomeAPIQueryParamModel {
    let startDate: String?
    let endDate: String?
    let todayDate: String?
    
}

///  This API will hold all APIs related to restaurant
enum HomeAPI {
    case getNearbyRestaurant(HomeAPIQueryParamModel?)
}

extension HomeAPI: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        case .getNearbyRestaurant(_):
            methodType = .get
        }
        return methodType
    }
    
    func apiEndPath() -> String {
        var apiEndPath = ""
        switch self {
        case .getNearbyRestaurant(let queryModel):
            if let nonNillQueryParam = queryModel{
                if let nonNilDate = nonNillQueryParam.todayDate{
                    apiEndPath += "&date=\(nonNilDate)"
                }
                if let nonNilStartDate = nonNillQueryParam.startDate{
                    apiEndPath += "&start_date=\(nonNilStartDate)"
                    
                }
                if let nonNilEndDate = nonNillQueryParam.endDate{
                    apiEndPath += "&end_date=\(nonNilEndDate)"
                    
                }
                
            }
        }
        return apiEndPath
    }
    
    func apiBasePath() -> String {
        switch self {
        case .getNearbyRestaurant(_):
            return ServiceConstants.baseURL + "/\(ServiceConstants.pod)"
        }
    }
}
