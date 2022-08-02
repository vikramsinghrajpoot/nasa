//
//  Enums.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation
import Network

enum EPODCellType: Int,CaseIterable{
    case today
    case previous
    case favourite
}

enum EDateType:Int{
    case startDate
    case endDate
}

extension EPODCellType{
    func title() -> String{
        return ["Today POD","Previous POD","Favourite"][self.rawValue]
    }
}
enum EPODSectionStataus: Int{
    case loading
    case done
}
