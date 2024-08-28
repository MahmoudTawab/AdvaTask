//
//  PhotoDetailViewController.swift
//  AdvaTask
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit

// MARK: - Photo Detail View Controller
class PhotoDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let photo: Photo
    private let imageView: UIImageView
    private var scrollView: UIScrollView!
    
    // MARK: - Initializers
    
    init(photo: Photo) {
        self.photo = photo
        self.imageView = UIImageView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImage()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // ScrollView setup
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.contentSize = imageView.bounds.size
        scrollView.addSubview(imageView)
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        
        // ImageView setup
        imageView.contentMode = .scaleAspectFit
        imageView.frame = scrollView.bounds
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .white
        
        // Double-tap gesture setup
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
    }
    
    // MARK: - Image Loading
    
    private func loadImage() {
        guard let url = URL(string: photo.url) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if error != nil {
                DispatchQueue.main.async {
                    self?.imageView.tintColor = .red
                    self?.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.imageView.frame.size = self?.scrollView.frame.size ?? .zero
                self?.centerImage()
            }
        }.resume()
    }
    
    // MARK: - Gesture Handling
    
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let pointInView = gesture.location(in: imageView)
        let newZoomScale = scrollView.zoomScale > scrollView.minimumZoomScale
            ? scrollView.minimumZoomScale
            : scrollView.maximumZoomScale
        
        let scrollViewSize = scrollView.bounds.size
        let width = scrollViewSize.width / newZoomScale
        let height = scrollViewSize.height / newZoomScale
        let originX = pointInView.x - (width / 2.0)
        let originY = pointInView.y - (height / 2.0)
        
        let rectToZoomTo = CGRect(x: originX, y: originY, width: width, height: height)
        scrollView.zoom(to: rectToZoomTo, animated: true)
    }
    
    // MARK: - Helper Methods
    
    private func centerImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size
        let horizontalPadding = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalPadding = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}

// MARK: - UIScrollViewDelegate

extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}
