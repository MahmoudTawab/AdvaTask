//
//  NetworkServiceTests.swift
//  AdvaTaskTests
//
//  Created by Mahmoud on 28/08/2024.
//

import XCTest
@testable import AdvaTask

class NetworkServiceTests: XCTestCase {

    var networkService: NetworkService!

    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testFetchDataSuccess() {
        let mockURL = "https://jsonplaceholder.typicode.com/photos"
        let expectation = self.expectation(description: "Fetching data succeeds")
        
        networkService.fetchData(from: mockURL) { (result: Result<[Photo], Error>) in
            switch result {
            case .success(let photos):
                XCTAssertFalse(photos.isEmpty, "Photos array should not be empty")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchDataFailure() {
        // إعداد URL غير صالح
        let mockURL = "invalid_url"
        let expectation = self.expectation(description: "Fetching data fails")

        networkService.fetchData(from: mockURL) { (result: Result<[Photo], Error>) in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
