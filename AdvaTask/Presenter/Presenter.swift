//
//  Presenter.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit
import Foundation

// MARK: - Presenter
class PhotoListPresenter: PhotoListPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: PhotoListViewProtocol?
    var interactor: PhotoListInteractorProtocol?
    var router: PhotoListRouterProtocol?
    
    private var currentPage = 1
    private var isLoading = false
    private var hasMorePhotos = true
    
    // MARK: - Methods
    
    func viewDidLoad() {
        loadPhotos()
    }
    
    func loadMorePhotos() {
        guard !isLoading else { return }
        loadPhotos()
    }
    
    private func loadPhotos() {
        isLoading = true
        view?.showLoading()
        
        interactor?.fetchPhotos(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            self.view?.hideLoading()
            
            switch result {
            case .success(let photos):
                if photos.isEmpty {
                    self.hasMorePhotos = false
                } else {
                    self.view?.showPhotos(photos)
                    self.currentPage += 1
                }
            case .failure(let error):
                self.view?.showError(error)
            }
        }
    }
    
    func didSelectPhoto(_ photo: Photo) {
        guard let viewController = view as? UIViewController else { return }
        router?.presentPhotoDetail(from: viewController, for: photo)
    }
    
    func didShowError(_ error: Error) {
        guard let viewController = view as? UIViewController else { return }
        router?.presentAlertController(from: viewController, for: error)
    }
}
