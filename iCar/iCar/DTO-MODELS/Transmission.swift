//
//  Transmission.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

enum Transmission: String, Codable {
    case a = "A"
    case m = "M"

    var displayValue: String {
        switch self {
        case .a: return "automatic"
        case .m: return "manual"
        }
    }
}
