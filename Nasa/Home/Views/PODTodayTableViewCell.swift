//
//  PODTableViewCell.swift
//  Nasa
//
//  Created by vikram on 30/07/22.
//

import UIKit

protocol PODTodayTableViewCellDelegate{
    func deleteFavouriteDidSelected(cell:PODTodayTableViewCell)
}

class PODTodayTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var pod: POD?
    @IBOutlet weak var dateLabel: UILabel!
    var delegate:PODTodayTableViewCellDelegate?
    
    @IBOutlet weak var favoriteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        guard let pod = pod else { return }
        if self.favoriteButton.tintColor == .red {
            CoreDataManager.shared.removeFavorite(date: pod.date ?? "", completion: { isRemovedFromFavorite in
                self.delegate?.deleteFavouriteDidSelected(cell: self)
                self.favoriteButton.tintColor = isRemovedFromFavorite ? .blue : .red
            })
        } else {
            CoreDataManager.shared.saveFavorite(data: pod, completion: { isFavorite in
                self.favoriteButton.tintColor = isFavorite ? .red : .blue
            })
        }
    }
    
    func setData(pod: POD?, status:EPODSectionStataus){
        self.pod = pod
        if let nonNilPod = pod{
            self.titleLbl.text = nonNilPod.title
            self.dateLabel.text = pod?.date ?? ""
            
            self.detailsLbl.text = nonNilPod.explanation
            if let url = nonNilPod.url {
                self.imgView.loadFrom(urlStr: url)
            }else{
                imgView.image = nil
            }
        }
        CoreDataManager.shared.isFavorite(date: pod?.date ?? "", completion: { isFavorite in
            self.favoriteButton.tintColor = isFavorite ? .red : .blue
        })
    }
    override func prepareForReuse() {
        imgView.image = nil
    }
    
}
