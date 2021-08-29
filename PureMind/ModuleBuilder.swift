//
//  ModuleBuilder.swift
//  PureMind
//
//  Created by Клим on 06.07.2021.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createWelcomeModule() -> UIViewController
    func createMenuModule() -> UIViewController
    func createProfileModule() -> UIViewController
    func createMoodModuleOne(mood: String, vcIndex: Int) -> UIViewController
    func createMoodModuleTwo(mood: String, vcIndex: Int) -> UIViewController
}

class ModuleBuilder: AssemblyBuilderProtocol{
    func createWelcomeModule() -> UIViewController {
        let welcomeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WelcomeVC") as WelcomeViewController
        let navC = UINavigationController(rootViewController: welcomeVC)
        return navC
    }
    
    func createMenuModule() -> UIViewController {
        let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MenuVC") as MenuViewController
        menuVC.presenter = MenuPresenter(view: menuVC)
        let navC = UINavigationController(rootViewController: menuVC)
        return navC
    }
    
    func createProfileModule() -> UIViewController {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProfileVC") as ProfileViewController
        profileVC.presenter = ProfilePresenter(view: profileVC)
        let navC = UINavigationController(rootViewController: profileVC)
        return navC
    }
    
    func createMoodModuleOne(mood: String, vcIndex: Int) -> UIViewController{
        let moodOneVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FirstQuestionVC") as FirstQuestionsViewController
        moodOneVC.vcIndex = vcIndex
        moodOneVC.presenter = FirstQuestionsPresenter(view: moodOneVC, currMood: mood)
        return moodOneVC
    }
    
    func createMoodModuleTwo(mood: String, vcIndex: Int) -> UIViewController{
        let moodTwoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SecondQuestionVC") as SecondQuestionsViewController
        moodTwoVC.vcIndex = vcIndex
        moodTwoVC.presenter = SecondQuestionsPresenter(view: moodTwoVC, currMood: mood)
        return moodTwoVC
    }
}
