//
//  PhotoListViewController.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit

// MARK: - View
class PhotoListViewController: UIViewController, PhotoListViewProtocol {
    
    // MARK: - Properties
    
    private var isLoading = false
    private var photos: [Photo] = []
    var presenter: PhotoListPresenterProtocol?
    private let loadingCell = LoadingCell(style: .default, reuseIdentifier: LoadingCell.identifier)
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.identifier)
        return table
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
    }
    
    // MARK: - PhotoListViewProtocol
    
    func showPhotos(_ newPhotos: [Photo]) {
        DispatchQueue.main.async {
            self.photos.append(contentsOf: newPhotos)
            self.isLoading = false
            self.tableView.reloadData()
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.presenter?.didShowError(error)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.isLoading = true
            self.tableView.tableFooterView = self.loadingCell
            self.loadingCell.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.isLoading = false
            self.tableView.tableFooterView = nil
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell")
        }
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 1.5 {
            loadMorePhotosIfNeeded()
        }
    }
    
    private func loadMorePhotosIfNeeded() {
        guard !isLoading else { return }
        presenter?.loadMorePhotos()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let photo = photos[indexPath.row]
        presenter?.didSelectPhoto(photo)
    }
}
