//
//  DataProvider.swift
//  XingRepos
//
//  Created by Amr ELghadban on 7/8/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import CoreData
import Foundation
import UIKit

/// A type that can convert itself into and out of an external representation.
typealias APIClinet = APIClientRequestForURLSession // APIClientRequestForAlamofire

class DataProvider {
    // SingleTon Varible for accessing the class.
    static let share = DataProvider()
    lazy var apiRequest: APIClinet = APIClinet()
    // This prevents others from using the default '()' initializer for this class.
    private init() {
    }

    /// Get Vehicles List
    ///
    /// - Parameter completionHandler: closuere that hold the return result
    func getVehicles(completionHandler: @escaping (_ isSuccess: Bool, _ status: ResponseStatus, _ result: [Displayable]?) -> Void) {
        ProgressLoader.show()

        guard let urlRoute = URLFactory.getURL(.cars).url else {
            completionHandler(false, ResponseStatus.invalidRequestObject, nil)
            ProgressLoader.dismiss()
            return
        }

        guard let urlRequest = apiRequest.createRequest(url: urlRoute, forceUpdate: false) else {
            completionHandler(false, ResponseStatus.invalidRequestObject, nil)
            ProgressLoader.dismiss()
            return
        }

        apiRequest.invoke(request: urlRequest) { response in
            ProgressLoader.dismiss()
            switch response {
            case .success(let value):

                guard let jsonData = value as? Data else {
                    completionHandler(false, ResponseStatus.errorInParsingResponse, nil)
                    return
                }
                guard let result = self.parsingVehicalsData(jsonData: jsonData, isObject: false) else {
                    completionHandler(false, ResponseStatus.errorInParsingResponse, nil)
                    return
                }
                completionHandler(true, ResponseStatus.success, result)

            case .failure(let error):

                let failureObject = self.failureErrorCompletionHandler(error: error)
                completionHandler(failureObject.0, failureObject.1, nil)
            }
        }
    }

    private func parsingVehicalsData(jsonData: Data, isObject: Bool) -> [Displayable]? {
        guard let repositoriesResponseResult = Vehicle.decodeJsonData(Vehicle.self, jsonData, false) as? [Displayable] else {
            return nil
        }

        guard repositoriesResponseResult.isEmpty == false else {
            return nil
        }

        return repositoriesResponseResult
    }
}

extension DataProvider {
    func failureErrorCompletionHandler(error: NetworkErrorCodeForResponse) -> (Bool, ResponseStatus, String) {
        switch error {
        case .errorInParsingResponse:
            return (false, ResponseStatus.errorInParsingResponse, "Connection error")
        case .errorStatus:
            return (false, ResponseStatus.errorStatus, "Can't Parse")
        case .noInternet:
            return (false, ResponseStatus.connectionError, "Connection error")
        }
    }
}
