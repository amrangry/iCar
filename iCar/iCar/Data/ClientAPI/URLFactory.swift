//
//  URLFactory .swift
//  XingRepos
//
//  Created by Amr ELghadban on 7/8/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

enum URLFactory {
    case getURL(EndPoint)

    enum EndPoint: String {
        case cars = "cars.json"
    }

    enum URLFactoryConstantsEnum: String {
        case scheme = "http://"
        case host = "www.codetalk.de"
        case basePathComponents = "/"
    }

    var url: URL? {
        switch self {
        case .getURL(let endPoint):
            let url = self.buildURL(parameters: self.mainDomain, endPoint.rawValue)
            return url
        }
    }

    var stringPath: String? {
        let url = self.url
        let urlAbsoluteString = url?.absoluteString
        return urlAbsoluteString
    }

    var mainDomain: String {
        let webServicePathURL = URLFactoryConstantsEnum.scheme.rawValue + URLFactoryConstantsEnum.host.rawValue + URLFactoryConstantsEnum.basePathComponents.rawValue
        return webServicePathURL
    }

    ///  Construct  URL by appending the parametrs "strings"
    ///
    /// - Parameter parameters: it take vardic paramter as String to build the url string
    /// - Returns: url string value
    func buildURL(parameters: String...) -> URL? {
        // construct a URL by appending the parametrs string
        var urlStringBuilder: String = ""
        for componentPath in parameters {
            urlStringBuilder += componentPath
        }

        // before passing the user's search string as a parameter to the query URL, you call addingPercentEncoding on the string to ensure that it's properly escaped
        let expectedCharSet = NSCharacterSet.urlQueryAllowed
        guard let allowedURL = urlStringBuilder.addingPercentEncoding(withAllowedCharacters: expectedCharSet) else {
            return nil
        }
        guard let url = URL(string: allowedURL) else {
            return nil
        }
        return url
    }
}
