//
//  TryingUIAndWorkingAppApp.swift
//  TryingUIAndWorkingApp
//
//  Created by Yonatan Golestany on 08/12/2024.
//

//
//  MultiWindowHomeKitAppApp.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import SwiftUI
import HomeKit

@main
struct MultiWindowHomeKitAppApp: App {
    @StateObject private var homeKitManager = HomeKitManager()
    @StateObject private var selectedAccessoryManager = SelectedAccessoryManager()

    var body: some Scene {
        WindowGroup(id: "MainWindow") {
            MainScreenView()
                .environmentObject(homeKitManager)
                .environmentObject(selectedAccessoryManager)
        }

        WindowGroup(id: "AccessoryDetailWindow") {
            AccessoryDetailView()
                .environmentObject(homeKitManager) // Add this line
                .environmentObject(selectedAccessoryManager)
        }
        .defaultSize(CGSize(width: 400, height: 300))
    }
}
