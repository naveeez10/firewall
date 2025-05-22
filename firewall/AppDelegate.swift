//
//  AppDelegate.swift
//  firewall
//
//  Created by Apple on 18/05/25.
//


import SwiftUI
import UserNotifications
import NetworkExtension

// 1️⃣ Classic delegate object
final class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        requestNotificationPermission()   // ask once at launch
        let suite = UserDefaults(suiteName: "group.com.naviz.VPNDemo")!
        var lastCount = 0

        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            let now = suite.stringArray(forKey: "blockedHosts") ?? []
            guard now.count > lastCount else { return }          // new entry added?
            lastCount = now.count
            let newest = now.last!

            let c = UNMutableNotificationContent()
            c.title = "Blocked \(newest)"
            c.body  = "Domain was dropped by the filter"
            UNUserNotificationCenter.current().add(
                UNNotificationRequest(identifier: UUID().uuidString,
                                      content: c,
                                      trigger: nil))
        }
        return true
    }

    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .notDetermined else { return }

            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, err in
                if let err { print("Notif auth error:", err) }
                print("Permission granted:", granted)
            }
        }
    }
}

// 2️⃣ SwiftUI entry point
@main
struct FirewallDemoApp: App {
    // Glue the old delegate in
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()            // your existing view
        }
    }
}
