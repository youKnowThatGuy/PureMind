//
//  ModuleBuilder.swift
//  PureMind
//
//  Created by Клим on 06.07.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createWelcomeModule() -> UIViewController
    func createSearchModule() -> UIViewController
}

class ModuleBuilder: AssemblyBuilderProtocol{
    func createWelcomeModule() -> UIViewController {
        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WelcomeVC") as WelcomeViewController
        let navC = UINavigationController(rootViewController: welcomeVC)
        
        return navC
    }
    
    func createSearchModule() -> UIViewController {
        
        return UIViewController()
    }
}
