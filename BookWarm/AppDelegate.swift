//
//  AppDelegate.swift
//  BookWarm
//
//  Created by 서동운 on 7/31/23.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureAppearance()
        var config = Realm.Configuration.init(schemaVersion: 3) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // publisher 추가
            }
            if oldSchemaVersion < 2 {
                // rate 삭제
            }
            if oldSchemaVersion < 3 {
                migration.renameProperty(onType: BookTable.className(), from: "backgroundColorTable", to: "backgroundColor")
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        // 릴리즈에는 절대 포함 x, 개발과정에서만 사용할 것!
        // configuration의 deleteRealmIfMigrationNeeded = true
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func configureAppearance() {
        UINavigationBar.appearance().tintColor = .black
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.tintColor = .black
        tabBarAppearance.backgroundColor = .white
    }
}

