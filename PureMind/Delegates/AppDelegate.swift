//
//  AppDelegate.swift
//  PureMind
//
//  Created by Клим on 06.07.2021.
//

import UIKit
import YandexMobileMetrica

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "cf14588a-3b7f-4f19-9978-79ee67b61f5c")
        YMMYandexMetrica.activate(with: configuration!)
        let center = UNUserNotificationCenter.current()
        
            //Delegate for UNUserNotificationCenterDelegate
            center.delegate = self
            
            //Permission for request alert, soud and badge
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                // Enable or disable features based on authorization.
                if(!granted){
                    print("not accept authorization")
                }else{
                    print("accept authorization")
                    
                    center.delegate = self
                    
                    
                }
            }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

