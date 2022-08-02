//
//  FavoriteViewController.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewModel: HomeViewModel!
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        registerNib()
        viewModel = HomeViewModel(delegate: self)
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.loadFavouriteData()
    }
    
    private func registerNib(){
        let nib = UINib.init(nibName: PODTodayTableViewCell.nameStr, bundle: nil)
        tableVIew.register(nib, forCellReuseIdentifier: PODTodayTableViewCell.nameStr)
    }
    
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouriteCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PODTodayTableViewCell.nameStr) as! PODTodayTableViewCell
        cell.delegate = self
        let pod:POD? = viewModel.favouriteFor(index: indexPath.row)
        cell.setData(pod: pod, status: viewModel.todaySectionStatus)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension FavoriteViewController: HomeViewModelDelegate {
    func loadingData(type: EPODCellType) {
        loader.startAnimating()
    }
    
    func dataLoaded(type: EPODCellType) {
        loader.stopAnimating()
        showNoFavaouriteMessage()
        tableVIew.reloadData()
    }
    
    func failedWithError(error: String?) {
        if let nonNilError = error {
            self.alert(message: Messages.error, title: nonNilError)
        }
        
    }
    
    private func showNoFavaouriteMessage(){
        if viewModel.favouriteCount() == 0{
            self.tableVIew.isHidden = true
        }else{
            self.tableVIew.isHidden = false
        }
    }
}

extension FavoriteViewController: PODTodayTableViewCellDelegate{
    //When favaourite added and removed
    func deleteFavouriteDidSelected(cell:PODTodayTableViewCell) {
        if let indexPath = self.tableVIew.indexPath(for: cell){
            viewModel.deleteFavouriteFor(index: indexPath.row)
            self.tableVIew.deleteRows(at: [indexPath], with: .automatic)
            showNoFavaouriteMessage()
        }
    }
    
}
