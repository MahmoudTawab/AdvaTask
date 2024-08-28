//
//  AppDelegate.swift
//  AdvaTask
//
//  Created by Mahmoud on on 28/08/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    
    var window: UIWindow?

    // MARK: - UIApplicationDelegate Methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize the main window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Setup the initial view controller
        let photoListViewController = PhotoListRouter.createPhotoListModule()
        let navigationController = UINavigationController(rootViewController: photoListViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        photoListViewController.title = "Photo Gallery"
        
        // Set the root view controller and make the window visible
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
