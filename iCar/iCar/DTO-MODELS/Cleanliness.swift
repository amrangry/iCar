//
//  Cleanliness.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

enum Cleanliness: String, Codable {
    case clean = "CLEAN"
    case regular = "REGULAR"
    case veryClean = "VERY_CLEAN"

    var displayValue: String {
        switch self {
        case .clean: return "clean"
        case .regular: return "regular"
        case .veryClean: return "very clean"
        }
    }
}
