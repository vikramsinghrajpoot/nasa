//
//  HomeServiceRequest.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation
typealias GetPODResponse = (Result<POD, Error>) -> Void
typealias GetPPODResponse = (Result<[POD], Error>) -> Void


protocol HomeServiceRequestType {
    @discardableResult func getPod(apiQueryModel: HomeAPIQueryParamModel?, completion: @escaping  GetPODResponse) -> URLSessionDataTask?
    @discardableResult func getPPod(apiQueryModel: HomeAPIQueryParamModel?, completion: @escaping  GetPPODResponse) -> URLSessionDataTask?
}

struct HomeServiceRequests: HomeServiceRequestType {
    
    @discardableResult func getPod(apiQueryModel: HomeAPIQueryParamModel?, completion: @escaping GetPODResponse) -> URLSessionDataTask? {
        
        let contactRequestModel = APIRequestModel(api: HomeAPI.getNearbyRestaurant(apiQueryModel))
        return ServiceHelper.requestAPI(apiModel: contactRequestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType:  POD.self, completion: { (allRestaurantResponse, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }
                    
                    if let restaurantResponse = allRestaurantResponse {
                        completion(.success(restaurantResponse))
                        return
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult func getPPod(apiQueryModel: HomeAPIQueryParamModel?, completion: @escaping GetPPODResponse) -> URLSessionDataTask? {
        
        let requestModel = APIRequestModel(api: HomeAPI.getNearbyRestaurant(apiQueryModel))
        return ServiceHelper.requestAPI(apiModel: requestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType:  [POD].self, completion: { (response, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }
                    
                    if let noneNillResponse = response {
                        completion(.success(noneNillResponse))
                        return
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
