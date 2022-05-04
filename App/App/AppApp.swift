//
//  AppApp.swift
//  App
//
//  Created by Kai Wang on 4/20/22.
//

import SwiftUI

@main
struct AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

public extension UIApplication {

    func clearLaunchScreenCache() {
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
        } catch {
            print("Failed to delete launch screen cache: \(error)")
        }
    }

}

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    try! FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")

    do {
        sleep(2)
    }

    return true
}
