//
//  PharmAppApp.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import SwiftUI

@main
struct PharmAppApp: App {
    // MARK: - Properties

    // swiftlint:disable:next weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var drugStore = DrugStore()

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(drugStore)
        }
    }
}
