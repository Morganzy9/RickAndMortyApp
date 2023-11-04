//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/26/23.
//

import UIKit

/// Controller which is Hold All Controllers
final class RMTabViewController: UITabBarController {
    
    var customTabBar = RMCustomTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        setTabBarAppearance()
        setDelegates()
        setTabs()
        
    }
    
    
    
}

//  MARK: - Extension + UITabBarControllerDelegate
extension RMTabViewController: UITabBarControllerDelegate {
    
    //  MARK: - Private Functions
    
    private func setDelegates() {
        delegate = self
    }
    
    private func setTabBarAppearance() {
        self.tabBar.backgroundColor = .secondarySystemBackground
        self.setValue(customTabBar, forKey: "TabBar")
        self.tabBar.tintColor = .green
        self.tabBar.unselectedItemTintColor = .black
    }
    
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
    
    private func animateTabSelection(_ selectedIndex: Int) {
        
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.selectedIndex = selectedIndex
        }, completion: nil)
    }
    
    //  MARK: - UITabBarControllerDelegate Functions
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            print("Selected tab index: \(selectedIndex)")
            
            animateTabSelection(selectedIndex)
        }
    }
    
}
