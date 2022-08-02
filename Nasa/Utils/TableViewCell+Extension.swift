//
//  TableViewCell.swift
//  Boulla
//
//  Created by Vikram Rajpoot on 23/05/20.
//  Copyright © 2020 Vikram Rajpoot. All rights reserved.
//

import UIKit

extension UITableViewCell{
    static var nameStr: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell{
    static var nameStr: String {
        return String(describing: self)
    }
}


extension UIViewController{
    static var name: String {
        return String(describing: self)
    }
}
