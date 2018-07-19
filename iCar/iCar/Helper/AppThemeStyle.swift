//
//  AppThemeStyle.swift
//  XingRepos
//
//  Created by Amr ELghadban on 7/8/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation
import UIKit

struct AppThemeStyle {
    struct Color {
        static let conatinerBgColor = UIColor.white
        static let grayColor = UIColor(red: 18 / 255, green: 101 / 255, blue: 103 / 255, alpha: 1)
        static let backgroundColor = UIColor(red: 235 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
        static let greenTextColor = UIColor(red: 1 / 255, green: 116 / 255, blue: 117 / 255, alpha: 1)
        static let lightGreenTextColor = UIColor(red: 179 / 255, green: 209 / 255, blue: 210 / 255, alpha: 1)
        static let darkGrayTextColor = UIColor(red: 46 / 255, green: 46 / 255, blue: 46 / 255, alpha: 1)
        static let lightGreenBackgroundColor = UIColor(red: 184 / 255, green: 222 / 255, blue: 0 / 255, alpha: 0.2)
    }

    struct Font {
        static let defult = UIFont.systemFont(ofSize: 14)
    }

    struct Sizes {
        static let topViewHeight = 120
        static let logoTopViewHeight = 50
        static let repositorieyCellInsets = UIEdgeInsets(top: 20, left: 8, bottom: 5, right: 8)
        static let repoCellEdgeMargin = 15
        static let repoCellTopMargin = 5
        static let repoCellSuperEdgeMargin = 0
        static let collectionViewTraillingLeadingMargin = CGFloat(30)
    }

    struct Resources {
        static let logo = "logo_xing"
    }
}
