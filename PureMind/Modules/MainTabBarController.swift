//
//  MainTabBarController.swift
//  PureMind
//
//  Created by Клим on 05.08.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let mod = ModuleBuilder()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .systemRed
        let menuVC = mod.createMenuModule()
        let item1 = UITabBarItem()
        item1.title = "Меню"
        item1.image = UIImage(systemName: "house.fill")
        menuVC.tabBarItem = item1
        self.viewControllers = [menuVC]
        
    }
    

}
