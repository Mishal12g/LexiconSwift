//
//  TabBarViewController.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarAppearance()
        let groupsVC = UINavigationController(rootViewController: GroupsViewController())
        groupsVC.tabBarItem = UITabBarItem(title: "Добавить", image: UIImage(systemName: "house.fill"), selectedImage: nil)
        groupsVC.setupBackground(backgroundColor: .mgBlue, tintColor: .white)
        
        let settingsVC = SettingsViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gearshape.fill"), selectedImage: nil)
        
        self.viewControllers = [groupsVC, settingsVC]
    }
}

extension TabBarViewController {
    func tabbarAppearance() {
        tabBar.backgroundColor = .mgBlue
        tabBar.barTintColor = .mgBlue
        tabBar.unselectedItemTintColor = .systemGray4
        tabBar.tintColor = .white
    }
}
