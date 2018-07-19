//
//  Storyboards.swift
//  iCar
//
//  Created by Amr ELghadban on 7/19/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

enum Storyboards: String {
    case Main

    var instance: UIStoryboard {
        let storyBoard = UIStoryboard(name: rawValue, bundle: Bundle.main)
        return storyBoard
    }
}
