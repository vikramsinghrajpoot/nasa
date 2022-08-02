//
//  PODHeaderViewCell.swift
//  Nasa
//
//  Created by vikram on 01/08/22.
//

import UIKit

//POD section header  based on Date Type
// Date type:
// - case startDate
// - case endDate
protocol PODHeaderViewCellDelegate{
    func datePressed(type:EDateType)
}

class PODHeaderViewCell: UITableViewHeaderFooterView {
    @IBOutlet weak var startDateLbl: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    var delegate:PODHeaderViewCellDelegate?
    
    
    @IBAction func datePressed(_ sender: UIButton) {
        if let type = EDateType(rawValue: sender.tag){
            self.delegate?.datePressed(type: type)
        }
    }
    
    func configureHeader(section:Int, todayStatus: EPODSectionStataus, previousStatus:EPODSectionStataus ){
        let type = EPODCellType(rawValue: section)
        if let nonNilTitle = type?.title(){
            titleLbl.text = nonNilTitle
        }
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = UIColor.lightGray
        if todayStatus == .loading {
            loaderView.startAnimating()
        }else{
            loaderView.stopAnimating()
        }
        
        if let nonNilType = type, nonNilType == .today{
            startDateLbl.isHidden = true
        }else{
            startDateLbl.isHidden = false
        }
        
    }
    
    override func prepareForReuse() {
        loaderView.stopAnimating()
    }
    
}
