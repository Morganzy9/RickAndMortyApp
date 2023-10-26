//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/26/23.
//

import UIKit

final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        setTabs()
    }

}

extension RMTabViewController {
    
    private func setTabs() {
        
        var viewControllers: [UIViewController] = [
            RMCharacterViewController(),
            RMLocationViewController(),
            RMEpisodeViewController(),
            RMSettingsViewController()
        ]
        
        let tabBarIcons = ["person", "globe", "tv", "gear"]

        for (index, viewController) in viewControllers.enumerated() {
            viewController.navigationItem.largeTitleDisplayMode = .automatic

            let navigationController = UINavigationController(rootViewController: viewController)
            
            navigationController.navigationBar.prefersLargeTitles = true
            
            navigationController.tabBarItem = UITabBarItem(title: viewController.title, image: UIImage(systemName: tabBarIcons[index]), tag: index)
            
            viewControllers[index] = navigationController
        }
        
        setViewControllers(viewControllers, animated: true)
    }
    
}

