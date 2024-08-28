//
//  Interactor.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import Foundation

// MARK: - Interactor
class PhotoListInteractor: PhotoListInteractorProtocol {
    
    // MARK: - Properties
    
    private let networkService: NetworkService
    
    // MARK: - Initializers
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    
    func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos?_page=\(page)&_limit=10"
        networkService.fetchData(from: urlString, completion: completion)
    }
}
