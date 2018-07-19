//
//  NSObject+Extension.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import Foundation

extension NSObject {
//    static var className: String {
//        return NSStringFromClass(type(of: self))
//    }

    static var className: String {
        return NSStringFromClass(self as AnyClass).components(separatedBy: ".").last ?? ""
    }

    static var classNameCleaned: String {
        let classNameString = className
        if classNameString.contains(".") {
            let namesArray = classNameString.components(separatedBy: ".")
            return namesArray.last ?? classNameString
        } else {
            return classNameString
        }
    }

}

extension NSObjectProtocol {

    static var name: String {
        return String(describing: Self.self)
    }
}
