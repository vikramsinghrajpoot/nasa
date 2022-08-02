//
//  ViewController.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel:HomeViewModel!
    @IBOutlet weak var tableVIew: UITableView!
    
    override func viewDidLoad() {
        registerNib()
        viewModel = HomeViewModel(delegate: self)
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchHomeData()
    }
    
    private func registerNib(){
        let nib = UINib.init(nibName: PODTodayTableViewCell.nameStr, bundle: nil)
        tableVIew.register(nib, forCellReuseIdentifier: PODTodayTableViewCell.nameStr)
        
        let header = UINib.init(nibName: "PODHeaderViewCell", bundle: nil)
        tableVIew.register(header, forHeaderFooterViewReuseIdentifier: "PODHeaderViewCell")
    }
}

extension HomeViewController: PODHeaderViewCellDelegate{
    
    func datePressed(type:EDateType) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller:DateViewController = storyBoard.instantiateViewController(withIdentifier: DateViewController.name) as! DateViewController
        controller.type = type
        controller.viewModel = viewModel
        self.navigationController?.present(controller, animated: true)
    }
    
}

