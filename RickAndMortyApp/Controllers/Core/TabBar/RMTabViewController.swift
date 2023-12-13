//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/26/23.
//

import UIKit

///// Controller which is Hold All Controllers
final class RMTabViewController: UITabBarController {
    
    //  MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = false
    }
    
    private func setTabBar() {
        setTabs()
        setDelegates()
        setTabBarAppearance()
    }
}

////  MARK: - Extension + UITabBarControllerDelegate
extension RMTabViewController: UITabBarControllerDelegate {
    
    //  MARK: - Pivate Methods
    
    private func setTabs() {
        
        var viewControllers: [UIViewController] = [
            RMCharacterViewController(),
            RMLocationViewController(),
            RMEpisodeViewController(),
            RMSettingsViewController()
        ]
        
        let tabBarIcons = ["person", "globe", "tv", "gear"]
        let tabBarTitles = ["Characters", "Locations", "Episodes", "Settings"]
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.navigationItem.largeTitleDisplayMode = .automatic
            
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.tintColor = .systemGreen
            navigationController.navigationBar.prefersLargeTitles = true
            
            navigationController.tabBarItem = UITabBarItem(title: tabBarTitles[index], image: UIImage(systemName: tabBarIcons[index]), tag: index)
            
            viewControllers[index] = navigationController
        }
        
        setViewControllers(viewControllers, animated: true)
    }
    
    private func setDelegates() {
        delegate = self
    }
    
    private func animateTabSelection(_ selectedIndex: Int) {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.selectedIndex = selectedIndex
        }, completion: nil)
    }
    
    /// TabBar Loking
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 13
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 4
        )
        
        roundLayer.fillColor = UIColor.secondarySystemBackground.cgColor
        roundLayer.path = bezierPath.cgPath
        
        tabBar.backgroundColor = .systemBackground
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowColor = UIColor.black.withAlphaComponent(0.6).cgColor
        tabBar.layer.shadowOffset = CGSize(width: -4, height: -6)
        tabBar.layer.shadowOpacity = 0.9
        tabBar.layer.shadowRadius = 20
        tabBar.tintColor = .green
        
        registerForTraitChanges([UITraitUserInterfaceStyle.self], handler: { (self: Self, previousTraitCollection: UITraitCollection) in
            roundLayer.fillColor = UIColor.secondarySystemBackground.cgColor
        })
    }
    
    
    //  MARK: - UITabBarControllerDelegate Functions
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            animateTabSelection(selectedIndex)
        }
    }
}
