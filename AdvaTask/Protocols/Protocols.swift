//
//  Protocols.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit
import Foundation

// View Protocol
// MARK: - PhotoListViewProtocol

protocol PhotoListViewProtocol: AnyObject {
    func showPhotos(_ photos: [Photo])
    func showError(_ error: Error)
    func showLoading()
    func hideLoading()
}

// MARK: - PhotoListInteractorProtocol

protocol PhotoListInteractorProtocol: AnyObject {
    func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
}

// MARK: - PhotoListPresenterProtocol

protocol PhotoListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectPhoto(_ photo: Photo)
    func didShowError(_ error: Error)
    func loadMorePhotos()
}

// MARK: - PhotoListRouterProtocol

protocol PhotoListRouterProtocol: AnyObject {
    static func createPhotoListModule() -> UIViewController
    func presentPhotoDetail(from view: UIViewController, for photo: Photo)
    func presentAlertController(from view: UIViewController, for error: Error)
}

