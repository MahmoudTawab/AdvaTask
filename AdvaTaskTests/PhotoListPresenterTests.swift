//
//  PhotoListPresenterTests.swift
//  AdvaTaskTests
//
//  Created by Mahmoud on 28/08/2024.
//

import XCTest
@testable import AdvaTask

class PhotoListPresenterTests: XCTestCase {

    var presenter: PhotoListPresenter!
    var mockView: MockPhotoListView!
    var mockInteractor: MockPhotoListInteractor!
    var mockRouter: MockPhotoListRouter!

    override func setUp() {
        super.setUp()
        mockView = MockPhotoListView()
        mockInteractor = MockPhotoListInteractor()
        mockRouter = MockPhotoListRouter()
        presenter = PhotoListPresenter()
        presenter.view = mockView
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
    }

    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func testViewDidLoadCallsLoadPhotos() {
        presenter.viewDidLoad()
        XCTAssertTrue(mockInteractor.fetchPhotosCalled, "fetchPhotos should be called")
    }

    func testDidSelectPhotoCallsRouter() {
        let photo = Photo(albumId: 1, id: 1, title: "Test Photo", url: "https://test.com/photo", thumbnailUrl: "https://test.com/thumbnail")
        presenter.didSelectPhoto(photo)
        XCTAssertTrue(mockRouter.presentPhotoDetailCalled, "presentPhotoDetail should be called")
    }
}

// Mock classes for testing
class MockPhotoListView: PhotoListViewProtocol {
    func showPhotos(_ photos: [Photo]) {}
    func showError(_ error: Error) {}
    func showLoading() {}
    func hideLoading() {}
}

class MockPhotoListInteractor: PhotoListInteractorProtocol {
    var fetchPhotosCalled = false
    func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        fetchPhotosCalled = true
        completion(.success([]))
    }
}

class MockPhotoListRouter: PhotoListRouterProtocol {
    var presentPhotoDetailCalled = false

    static func createPhotoListModule() -> UIViewController {
        return UIViewController()
    }

    func presentPhotoDetail(from view: UIViewController, for photo: Photo) {
        presentPhotoDetailCalled = true
    }
    
    func presentAlertController(from view: UIViewController, for error: Error) {
        // Mock implementation
    }
}

