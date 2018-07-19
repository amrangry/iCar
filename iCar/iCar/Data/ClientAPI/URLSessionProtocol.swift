//
//  URLSessionProtocol.swift
//  XingRepos
//
//  Created by Amr ELghadban on 7/16/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
}
