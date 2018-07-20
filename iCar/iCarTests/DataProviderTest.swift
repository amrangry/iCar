//
//  DataProviderTest.swift
//  iCarTests
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

@testable import iCar
import XCTest

class DataProviderTest: XCTestCase {
    var dataProviderUnderTest: DataProvider!
    var vehiclesViewModelUnderTest: VehiclesViewModel!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "CarsResponseMockup", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)

        guard let url = URLFactory.getURL(.cars).url else {
            // then
            XCTFail("url not valid")
            return
        }
        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        let sessionMock = URLSessionMockup(data: data, response: urlResponse, error: nil)
        let apiRequestUnderTest = APIClinet(configuration: sessionMock)
        dataProviderUnderTest = DataProvider.share
        dataProviderUnderTest.apiRequest = apiRequestUnderTest

        vehiclesViewModelUnderTest = VehiclesViewModel(dataProvider: dataProviderUnderTest)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataProviderUnderTest = nil
        vehiclesViewModelUnderTest = nil
        super.tearDown()
    }

    /// This is an example of test case for calling API
    /// Fake URLSession with DHURLSession protocol and stubs
    func testCarsAPICall_ParsesData() {
        // given
        weak var expectation = self.expectation(description: "Response Received and parsed correct")
        // when
        XCTAssertEqual(vehiclesViewModelUnderTest.dataSourceObjects.count, 0, "dataSourceObjects should be empty before the data task runs")
        dataProviderUnderTest.getVehicles { isSuccess, status, result in
            // then
            if isSuccess {
                guard let result = result as? [Vehicle] else {
                    XCTFail("Error: \(status.rawValue)")
                    return
                }
                self.vehiclesViewModelUnderTest.dataSourceObjects = result
                expectation?.fulfill()
            } else {
                XCTFail("Error: \(status.rawValue)")
            }
        }

        waitForExpectations(timeout: 30) { error in
            // then
            XCTAssertNil(error)
        }

        // then
        XCTAssertEqual( vehiclesViewModelUnderTest.dataSourceObjects.count, 28, "Didn't parse 28 items from fake response")
    }
}
