//
//  DateViewController.swift
//  Nasa
//
//  Created by vikram on 01/08/22.
//

import UIKit

class DateViewController: UIViewController {
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    var type:EDateType = .startDate
    var viewModel:HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let type = EDateType(rawValue: sender.tag)
        if let noneNilType = type, noneNilType == .startDate{
            viewModel.startDate = sender.date.string()
        }else{
            viewModel.endDate = sender.date.string()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let nonNilStartDate = viewModel.startDate, let nonNilEndDate = viewModel.endDate {
            viewModel.loadPPodData(startDate: nonNilStartDate, endDate: nonNilEndDate)
        }
    }
    
}
