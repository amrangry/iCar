//
//  MainStoryBoardTest.swift
//  iCarTests
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

@testable import iCar
import XCTest

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

    func testVehiclesConatinerViewControllerFromStoryBoard() {
        let vehiclesConatinerViewController = storyboard?.instantiateViewController(withIdentifier: "VehiclesConatinerViewController")

        XCTAssertNotNil(vehiclesConatinerViewController)
        // XCTAssertTrue(vehiclesConatinerViewController is VehiclesConatinerViewController)
    }

    func testVehiclesConatinerViewControllerFromInstantaitedFactoryMethod() {
        let vehiclesConatinerViewController = VehiclesConatinerViewController.instantiateFromStoryboard()

        XCTAssertNotNil(vehiclesConatinerViewController)
        XCTAssertTrue(vehiclesConatinerViewController is VehiclesConatinerViewController)
    }

    func testListDisplayViewControllerFromStoryBoard() {
        let listDisplayViewController = storyboard?.instantiateViewController(withIdentifier: "ListDisplayViewController")

        XCTAssertNotNil(listDisplayViewController)
        // XCTAssertTrue(listDisplayViewController is ListDisplayViewController)
    }

    func testListDisplayViewControllerFromInstantaitedFactoryMethod() {
        let listDisplayViewController = ListDisplayViewController.instantiateFromStoryboard()

        XCTAssertNotNil(listDisplayViewController)
        XCTAssertTrue(listDisplayViewController is ListDisplayViewController)
    }

    func testMapDisplayViewControllerFromStoryBoard() {
        let mapDisplayViewController = storyboard?.instantiateViewController(withIdentifier: "MapDisplayViewController")

        XCTAssertNotNil(mapDisplayViewController)
        // XCTAssertTrue(mapDisplayViewController is MapDisplayViewController)
    }

    func testMapDisplayViewControllerFromInstantaitedFactoryMethod() {
        let mapDisplayViewController = MapDisplayViewController.instantiateFromStoryboard()

        XCTAssertNotNil(mapDisplayViewController)
        XCTAssertTrue(mapDisplayViewController is MapDisplayViewController)
    }
}
