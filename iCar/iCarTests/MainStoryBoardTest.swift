//
//  MainStoryBoardTest.swift
//  iCarTests
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import XCTest

@testable import iCar

class MainStoryBoardTest: XCTestCase {

    // MARK: Varibels To test

    var storyboard: UIStoryboard?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main",
                                  bundle: Bundle.main)

        XCTAssertNotNil(storyboard)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        super.tearDown()
    }

    func testVehiclesListViewController() {
        let vehiclesListViewController = storyboard?.instantiateViewController(withIdentifier: "VehiclesListViewController")

        XCTAssertNotNil(vehiclesListViewController)
        //XCTAssertTrue(vehiclesListViewController is VehiclesListViewController)
    }

}
