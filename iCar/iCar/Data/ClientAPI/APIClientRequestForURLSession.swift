//
//  APIClientRequestForURLSession.swift
//  RealEstate
//
//  Created by Amr ELghadban on 6/14/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

class APIClientRequestForURLSession {
    // create and initialize URLSession with a default session configuration
    var defaultSession: URLSessionProtocol = URLSession(configuration: URLSessionConfiguration.default)
    // declare a URLSessionDataTask which you'll use to make an HTTP request
    var dataTask: URLSessionDataTask?

    init() {
    }

    convenience init(configuration: URLSessionProtocol) {
        self.init()
        defaultSession = configuration
    }

    // MARK: - Helper Methods

    func errorMapping(_ errorRaw: Error) -> NetworkErrorCodeForResponse {
        if let error = errorRaw as? URLError {
            debugPrint("URLError occurred: \(error)")
            return NetworkErrorCodeForResponse.noInternet
        } else {
            debugPrint("Unknown error: \(errorRaw)")
            return NetworkErrorCodeForResponse.errorStatus
        }
    }

    func createRequest(url: URL, forceUpdate: Bool) -> URLRequest? {
        var request = URLRequest(url: url, cachePolicy: forceUpdate ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad, timeoutInterval: 10)

        // All app requests are GET, and expect JSON response
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
       // request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        return request
    }

    func invoke(request: URLRequest, completionHandler: @escaping (NetworkResult<Any>) -> Void) {
        dataTask = defaultSession.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil && data != nil else {
                completionHandler(NetworkResult.failure(.noInternet))
                return
            }

            guard let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 else {
                completionHandler(NetworkResult.failure(.errorStatus))
                return
            }

            guard let dataResult = data else {
                completionHandler(NetworkResult.failure(.errorStatus))
                return
            }

            DispatchQueue.main.async {
                completionHandler(NetworkResult.success(dataResult))
            }
        })
        // all tasks start in a suspended state by default, calling resume() starts the data task
        dataTask?.resume()
    }

    func invoke(_ url: URL, completionHandler: @escaping (NetworkResult<Any>) -> Void) {
        guard let urlRequest = createRequest(url: url, forceUpdate: false) else {
            assertionFailure("URL can't be nil")
            return
        }

        invoke(request: urlRequest) { response in
            completionHandler(response)
        }
    }
}

// Handling DataTask LifeCycle
extension APIClientRequestForURLSession {
    func startTask() {
        dataTask?.resume()
    }

    func cancelTask() {
        dataTask?.cancel()
    }

    func resumeTask() {
        dataTask?.resume()
    }

    func suspendTask() {
        dataTask?.suspend()
    }
}
