//
//  URLFactoryTests.swift
//  iCarTests
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import XCTest

@testable import iCar

class URLFactoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAPIPathStringForCars() {
        let stringPath = URLFactory.getURL(.cars).stringPath
        XCTAssertNotNil(stringPath)
        let isConatinedJsonString = stringPath?.contains(".json")
        XCTAssertTrue(isConatinedJsonString!)
    }

    /// This is an example of a functional test case API Path it shouldn't be null
    func testAPIPathURL() {
        let url = URLFactory.getURL(.cars).url
        XCTAssertNotNil(url)
    }

}
