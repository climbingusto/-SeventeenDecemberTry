//
//  AccessoryButtonView.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import SwiftUI
import HomeKit

struct AccessoryButtonView: View {
    let accessory: HMAccessory
    let icon: String

    @EnvironmentObject var homeKitManager: HomeKitManager
    @EnvironmentObject var selectedAccessoryManager: SelectedAccessoryManager
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        let isOn = homeKitManager.deviceStates[accessory.uniqueIdentifier] ?? false

        Button(action: {
            homeKitManager.toggleDevice(accessory)
            selectedAccessoryManager.selectedAccessory = accessory
            openWindow(id: "AccessoryDetailWindow")
        }) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 100)
                .overlay(
                    VStack {
                        Image(systemName: isOn ? "\(icon).fill" : icon)
                            .font(.system(size: 30))
                            .foregroundColor(isOn ? .yellow : .gray)
                        Text(accessory.name)
                            .font(.caption)
                    }
                )
        }
    }
}
