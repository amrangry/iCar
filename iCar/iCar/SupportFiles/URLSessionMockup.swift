//
//  URLSessionMockup.swift
//  ADKA
//
//  Created by Amr ELghadban on 6/11/18.
//  Copyright © 2018 Adka. All rights reserved.
//

import Foundation

public final class URLSessionMockup {
    var url: URL?
    var request: URLRequest?
    private let dataTaskMock: URLSessionDataTaskMock

    public convenience init?(jsonDict: [String: Any], response: URLResponse? = nil, error: Error? = nil) {
        guard let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else { return nil }
        self.init(data: data, response: response, error: error)
    }

    public init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.dataTaskMock = URLSessionDataTaskMock()
        self.dataTaskMock.taskResponse = (data, response, error)
    }
}

extension URLSessionMockup: URLSessionProtocol {
    public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.url = url
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }

    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        self.dataTaskMock.completionHandler = completionHandler
        return self.dataTaskMock
    }
}

private final class URLSessionDataTaskMock: URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (Data?, URLResponse?, Error?)?

    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler?(self.taskResponse?.0, self.taskResponse?.1, self.taskResponse?.2)
        }
    }
}
