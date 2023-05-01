//
//  liverApp.swift
//  liver
//
//  Created by 島田雄介 on 2023/05/01.
//

import SwiftUI
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                        GADMobileAds.sharedInstance().start(completionHandler: nil)
                        return true
                    }
    
}
@main
struct liverApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
