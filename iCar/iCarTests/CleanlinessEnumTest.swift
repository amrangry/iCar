//
//  CleanlinessEnumTest.swift
//  iCarTests
//
//  Created by Amr ELghadban on 7/20/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import XCTest

class CleanlinessEnumTest: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        XCTAssertFalse(Cleanliness.regular.rawValue != "REGULAR")
        XCTAssertFalse(Cleanliness.clean.rawValue != "CLEAN")
        XCTAssertFalse(Cleanliness.veryClean.rawValue != "VERY_CLEAN")
    }
}
