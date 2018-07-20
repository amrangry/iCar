//
//  APIClientTest.swift
//  iCarTests
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

@testable import iCar
import XCTest

class APIClientTest: XCTestCase {
    var apiRequestUnderTest: APIClinet!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        apiRequestUnderTest = APIClinet(configuration: sessionUnderTest)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiRequestUnderTest = nil
        super.tearDown()
    }

    /// This is an example of test case for calling API
    func testCarsAPICall() {
        // given
        weak var expectation = self.expectation(description: "Response Received")
        var responseError: Error?

        guard let urlRoute = URLFactory.getURL(.cars).url else {
            // then
            XCTFail("url not valid")
            return
        }

        guard let urlRequest = apiRequestUnderTest.createRequest(url: urlRoute, forceUpdate: false) else {
            // then
            XCTFail("URLRequest not valid")
            return
        }

        // when
        apiRequestUnderTest.invoke(request: urlRequest) { result in
            // then
            XCTAssertNotNil(result)
            switch result {
            case .success(let value):
                XCTAssertNotNil(value)
                expectation?.fulfill()
            case .failure(let error):
                responseError = error
                XCTFail("Error: \(error.localizedDescription)")
            }
        }

        waitForExpectations(timeout: 30) { error in
            // then
            XCTAssertNil(error)
        }

        XCTAssertNil(responseError)
    }
}
