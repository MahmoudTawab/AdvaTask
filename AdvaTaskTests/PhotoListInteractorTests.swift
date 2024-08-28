//
//  PhotoListInteractorTests.swift
//  AdvaTaskTests
//
//  Created by Mahmoud on 28/08/2024.
//

import XCTest
@testable import AdvaTask

class PhotoListInteractorTests: XCTestCase {

    var interactor: PhotoListInteractor!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        interactor = PhotoListInteractor(networkService: mockNetworkService)
    }

    override func tearDown() {
        interactor = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchPhotosSuccess() {
        let expectation = self.expectation(description: "Photos fetch succeeds")
        interactor.fetchPhotos(page: 1) { result in
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
}

// Mock Network Service
class MockNetworkService: NetworkService {
    override func fetchData<T: Decodable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        // Return mock data
        let mockPhotos = [Photo(albumId: 1, id: 1, title: "Test", url: "https://test.com", thumbnailUrl: "https://test.com")]
        completion(.success(mockPhotos as! T))
    }
}

