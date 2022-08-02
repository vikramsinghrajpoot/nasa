//
//  HomeViewModel.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation

protocol HomeViewModelDelegate{
    func loadingData(type:EPODCellType)
    func dataLoaded(type:EPODCellType)
    func failedWithError(error:String?)
}

class HomeViewModel{
    var delegate:HomeViewModelDelegate?
    private var todayPodData:POD?
    private var previousPodData:[POD]?
    var todaySectionStatus:EPODSectionStataus = .loading
    var previousSectionStatus:EPODSectionStataus = .loading
    private var favourites:[POD]?
    var startDate:String?
    var endDate:String?
    
    init(delegate: HomeViewController) {
        self.delegate = delegate
        
    }
    
    func fetchHomeData(){
        loadPodData()
        loadPPodData()
    }
    
    init(delegate: FavoriteViewController) {
        self.delegate = delegate
    }
    
    //Load POD current data
    private func loadPodData(){
        HomeServiceRequests().getPod(apiQueryModel: nil) {[weak self] apiResult in
            switch apiResult {
            case .success(let podList):
                self?.todaySectionStatus = .done
                self?.todayPodData = podList
                self?.delegate?.dataLoaded(type: EPODCellType.today)
                
            case .failure(let error):
                print("Error \(error)")
                self?.delegate?.failedWithError(error: error.localizedDescription)
            }
        }
    }
    
    //Load previous POD data
    // - By default last 5 day data
    // - filter based on Start and End date
    func loadPPodData(startDate:String = Date.now.advanced(by: -TimeInterval(60 * 60 * 24 * 10)).string(), endDate:String = Date.now.string()){
        self.previousPodData?.removeAll()
        self.previousSectionStatus = .loading
        self.delegate?.loadingData(type: .previous)
        let query:HomeAPIQueryParamModel  = HomeAPIQueryParamModel(startDate: startDate, endDate: endDate, todayDate: nil)
        HomeServiceRequests().getPPod(apiQueryModel: query) {[weak self] apiResult in
            switch apiResult {
            case .success(let podList):
                self?.previousSectionStatus = .done
                self?.previousPodData = podList
                self?.delegate?.dataLoaded(type: EPODCellType.previous)
                //                print("Error\(podList)")
                
            case .failure(let error):
                self?.delegate?.failedWithError(error: error.localizedDescription)
                print("Error \(error)")
            }
        }
    }
    
    //All favourite data from local data base
    private func loadFavoriteData() {
        self.delegate?.loadingData(type: .favourite)
        CoreDataManager.shared.retrieveData(completion: { podList in
            self.favourites = podList
            self.delegate?.dataLoaded(type: .favourite)
            
        })
    }
    
    func getPodData() -> POD? {
        return todayPodData ?? nil
    }
    
    func getPodPrevData() -> [POD]? {
        return previousPodData ?? nil
    }
    
    func getPreviousPod(index:Int) -> POD?{
        return previousPodData?[index]
    }
    
    func favouriteCount() -> Int {
        return favourites?.count ?? 0
    }
    func favouriteFor(index:Int) -> POD? {
        if let nonNilFavourites = favourites {
            return nonNilFavourites[index]
        }else{
            return nil
        }
    }
    
    func loadFavouriteData(){
        loadFavoriteData()
    }
    
    func deleteFavouriteFor(index:Int){
        if var _ = favourites {
            favourites!.remove(at: index)
        }
    }
    
}
