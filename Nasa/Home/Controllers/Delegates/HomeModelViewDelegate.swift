//
//  HomeModelViewDelegate.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation
extension HomeViewController: HomeViewModelDelegate {
    func loadingData(type: EPODCellType) {
        if(type == .today){
            self.tableVIew.reloadSections([EPODCellType.today.rawValue], with: .automatic)
        }else{
            self.tableVIew.reloadSections([EPODCellType.previous.rawValue], with: .automatic)
        }    }
    
    func dataLoaded(type: EPODCellType) {
        if(type == .today){
            self.tableVIew.reloadSections([EPODCellType.today.rawValue], with: .automatic)
        }else{
            self.tableVIew.reloadSections([EPODCellType.previous.rawValue], with: .automatic)
        }
    }
    
    func failedWithError(error: String?) {
        if let nonNilError = error{
            self.viewModel.previousSectionStatus = .done
            self.viewModel.todaySectionStatus = .done
            self.alert(message: Messages.error, title: nonNilError)
            self.tableVIew.reloadData()
        }
    }
}

