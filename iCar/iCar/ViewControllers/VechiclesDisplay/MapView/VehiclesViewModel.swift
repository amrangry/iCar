//
//  VehiclesViewModel.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

protocol VehiclesViewModelDelegate: class {
    func successRetrivingResult()
    func failureRetrivingResult(error msg: String)
}

class VehiclesViewModel: NSObject {

    // MARK: - Public Varibles

    weak var delegate: VehiclesViewModelDelegate?
    var dataSourceObjects = [Vehicle]()

    // MARK: - Private Varibles

    private var dataProvider: DataProvider

    /// Designer Constractor USing DI to instantiate Object Form ViewModel
    ///
    /// - Parameter dataProvider: DataProvider object
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    /// fetch Data from source etc ..Webservice/DataBase
    func fetchData() {
        dataProvider.getVehicles { isSuccess, status, result in
            if isSuccess {
                guard let result = result as? [Vehicle] else {
                    return
                }
                self.dataSourceObjects = result
                self.delegate?.successRetrivingResult()
            } else {
                var msg = "Message"
                switch status {
                case .connectionError,
                     .unknown: /* unknown status come from backend */
                    msg = "Connection error"
                default:
                    msg = "No Data Found"
                }

                self.delegate?.failureRetrivingResult(error: msg)
            }
        }
    }
}
