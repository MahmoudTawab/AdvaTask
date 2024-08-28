//
//  LoadingCell.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit

// MARK: - LoadingCell
class LoadingCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "LoadingCell"
    
    // MARK: - UI Components
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Animation Control
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
