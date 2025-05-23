//
//  AppDelegate.swift
//  firewall
//
//  Created by Apple on 18/05/25.
//


import SwiftUI
import UserNotifications
import NetworkExtension

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }
}

// 2️⃣ SwiftUI entry point
@main
struct FirewallDemoApp: App {
    // Glue the old delegate in
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
