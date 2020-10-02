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
    @State var selectedView = 0

    @StateObject private var drugStore = DrugStore()

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView()
                    .environmentObject(drugStore)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("§Rechercher")
                    }
                    .tag(0)

                ScanView()
                    .tabItem {
                        Image(systemName: "barcode.viewfinder")
                        Text("§Scanner")
                    }
                    .tag(1)
            }
        }
    }
}
