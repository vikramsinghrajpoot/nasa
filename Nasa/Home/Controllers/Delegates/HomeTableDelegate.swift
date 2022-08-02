//
//  HomeTableDelegate.swift
//  Nasa
//
//  Created by vikram on 30/07/22.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EPODCellType(rawValue: section) == .today ? ((viewModel.getPodData() == nil) ? 0 : 1 ) : viewModel.previousSectionStatus == .loading ? 1 : viewModel.getPodPrevData()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = EPODCellType(rawValue: indexPath.section)
        if(type == .today && viewModel.todaySectionStatus == .done){
            if(viewModel.todaySectionStatus == .loading){
                let cell = UITableViewCell()
                cell.textLabel?.text = Messages.loading
                cell.textLabel?.textAlignment = .center
                cell.contentView.startBlueAnimating()
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: PODTodayTableViewCell.nameStr) as! PODTodayTableViewCell
                cell.setData(pod: viewModel.getPodData(), status: viewModel.todaySectionStatus)
                return cell
            }
            
        }
        else{
            if(viewModel.previousSectionStatus == .loading){
                let cell = UITableViewCell()
                cell.textLabel?.text = Messages.loading
                cell.textLabel?.textAlignment = .center
                return cell
                
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: PODTodayTableViewCell.nameStr) as! PODTodayTableViewCell
                let pod:POD? = viewModel.getPreviousPod(index: indexPath.row)
                cell.setData(pod: pod, status: viewModel.todaySectionStatus)
                if(viewModel.previousSectionStatus == .loading){ cell.startBlueAnimating()}
                return cell
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:PODHeaderViewCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PODHeaderViewCell") as! PODHeaderViewCell
        headerView.delegate = self
        headerView.configureHeader(section: section, todayStatus: viewModel.todaySectionStatus, previousStatus: viewModel.previousSectionStatus )
        return headerView
        
    }
    
}
