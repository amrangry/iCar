//
//  Vehicle.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation
struct Vehicle: Codable, Displayable, JSONDecoderable {
    let id, modelIdentifier, modelName, name: String?
    let make: String?
    let group: String?
    let color, series: String?
    let fuelType: Fuel?
    let fuelLevel: Double?
    let transmission: Transmission?
    let licensePlate: String?
    let latitude, longitude: Double?
    let innerCleanliness: Cleanliness?
    let carImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, modelIdentifier, modelName, name, make, group, color, series, fuelType, fuelLevel, transmission, licensePlate, latitude, longitude, innerCleanliness
        case carImageURL = "carImageUrl"
    }
}
