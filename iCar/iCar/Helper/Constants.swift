//
//  Constants.swift
//  NYTimes
//
//  Created by Amr ELghadban on 6/30/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation
import UIKit.UIColor
public typealias JSONDictionary = [String: AnyObject]

struct Constants {
    static let APIKey = "6862571d05e044eb95d7e49076dc7b34"

    struct Theme {
        static let defultCellImageName = "default_placeholder"
        static let mainTiteColor = UIColor.init(red: 57/255, green: 153/255, blue: 216/255, alpha: 1.0)
    }

    struct Config {
        static let latitude = 48.134557
        static let longitude = 11.576921
        static let distance = 1000
    }
}
