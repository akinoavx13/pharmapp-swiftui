//
//  AppDelegate.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        ImportService.shared.loadItems()
        return true
    }
}
