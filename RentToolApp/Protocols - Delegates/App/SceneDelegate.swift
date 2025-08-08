//
//  SceneDelegate.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 23.07.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        var _: UserRole
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let homeVC = HomeViewController(userRole: .admin)
        let homeNC = UINavigationController(rootViewController: homeVC)
        
        let settingsVC = SettingsViewController()
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        
        //        if userRole == .admin {
        //            let addPropertyVC = AddPropertyViewController()
        //            let addPropertyNC = UINavigationController(rootViewController: addPropertyVC)
        //            settingsNC.viewControllers.append(addPropertyNC)
        //        }
        
        let favoritesVC = FavoritesViewController()
        let favoritesNC = UINavigationController(rootViewController: favoritesVC)
        
        let historyVC = HistoryViewController()
        let historyNC = UINavigationController(rootViewController: historyVC)
        
        //MARK: - TabBar
        
        let tabBarController = UITabBarController()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 2)
        
        historyVC.tabBarItem = UITabBarItem(title: "History", image: UIImage(systemName: "clock"), tag: 3)
        
        
        tabBarController.setViewControllers([homeNC, favoritesNC, historyNC, settingsNC], animated: true)
        
        //MARK: - Tab Bar Appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .tabAndNav
        tabBarAppearance.shadowColor = .clear
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
//        tabBarAppearance.configureWithOpaqueBackground() // və ya configureWithDefaultBackground()

        

        // Normal (seçilməmiş) item rəngi
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .tabBar
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.tabBar]

        // Seçilmiş item rəngi
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .button
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.button]

        
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        //MARK: - Navigation Bar Appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .tabAndNav
        navBarAppearance.shadowColor = .clear
        _ = NSAttributedString.Key.self
        UINavigationBar.appearance().tintColor = .label

        
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        
        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        
        
        window.rootViewController = tabBarController
        
        self.window = window
        
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
}

