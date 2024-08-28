//
//  Router.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit
import Foundation

// MARK: - Router
class PhotoListRouter: PhotoListRouterProtocol {
    
    // MARK: - Methods
    
    static func createPhotoListModule() -> UIViewController {
        let view = PhotoListViewController()
        let interactor = PhotoListInteractor(networkService: NetworkService())
        let presenter = PhotoListPresenter()
        let router = PhotoListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
    }
    
    func presentPhotoDetail(from view: UIViewController, for photo: Photo) {
        let detailVC = PhotoDetailViewController(photo: photo)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func presentAlertController(from view: UIViewController, for error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        view.navigationController?.present(alert, animated: true, completion: nil)
    }
}

