//
//  MainTabBarViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 23.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
    }
    
    private func createNavController(viewController: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(named: itemImage), tag: 0)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = UIColor.varna
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.tabBarItem = item
        return navigationController
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = #colorLiteral(red: 0.9607843757, green: 0.9607843757, blue: 0.9607843757, alpha: 1)
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = #colorLiteral(red: 0.7098039216, green: 0.6901960784, blue: 0.6196078431, alpha: 1).cgColor
    }

    private func setupItems() {
        let appVC = AppSearchBuilder.build()
        appVC.navigationItem.title = "Search via iTunes"
        let searchAppViewController = createNavController(viewController: appVC, itemName: "Apps", itemImage: "gamecontroller.fill")
        
        let songVC = SongSearchBuilder.build()
        songVC.navigationItem.title = "Search via iTunes"
        let searchSongsViewController = createNavController(viewController: songVC, itemName: "Songs", itemImage: "music.note")
        viewControllers = [searchAppViewController, searchSongsViewController]
    }
}
