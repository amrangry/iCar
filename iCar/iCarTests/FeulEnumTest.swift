//
//  FeulEnumTest.swift
//  iCarTests
//
//  Created by Amr ELghadban on 7/20/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import XCTest

class FeulEnumTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        XCTAssertFalse(Fuel.d.rawValue != "D")
        XCTAssertFalse(Fuel.e.rawValue != "E")
        XCTAssertFalse(Fuel.p.rawValue != "P")
    }
}
