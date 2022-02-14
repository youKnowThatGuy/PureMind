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
        tabBar.tintColor = lightBlueColor
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 10)!], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for:.selected)
        
        let menuVC = mod.createMenuModule()
        let item1 = UITabBarItem()
        item1.title = "Меню"
        item1.image = UIImage(named: "tabBar1")
        menuVC.tabBarItem = item1
        
        /*
        let therapistVC = mod.createTherapistModule()
        let item2 = UITabBarItem()
        item2.title = "Терапевт"
        item2.image = UIImage(named: "tabBar2")
        therapistVC.tabBarItem = item2
 */
        
        let coursesVC = mod.createCoursesModule()
        let item3 = UITabBarItem()
        item3.title = "Курсы"
        item3.image = UIImage(named: "tabBar3")
        coursesVC.tabBarItem = item3
        
        let practicsVC = mod.createPracticModule()
        let item4 = UITabBarItem()
        item4.title = "Практики"
        item4.image = UIImage(named: "tabBar4")
        practicsVC.tabBarItem = item4
        
        let profileVC = mod.createProfileModule()
        let item5 = UITabBarItem()
        item5.title = "Профиль"
        item5.image = UIImage(named: "tabBar5")
        profileVC.tabBarItem = item5
        
        self.viewControllers = [menuVC, coursesVC, practicsVC, profileVC]
        
    }
    

}
