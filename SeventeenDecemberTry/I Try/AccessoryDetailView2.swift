//
//  AccessoryDetailView.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import SwiftUI
import HomeKit

struct AccessoryDetailView2: View {
    @EnvironmentObject var selectedAccessoryManager: SelectedAccessoryManager
    @EnvironmentObject var homeKitManager: HomeKitManager
    
    // A local state variable that holds the accessory this window is dedicated to
    @State private var currentAccessory: HMAccessory? = nil
    
    var body: some View {
        if let accessory = currentAccessory {
            let isOn = homeKitManager.deviceStates[accessory.uniqueIdentifier] ?? false
            
            VStack {
                Button {
                    // Toggle the button's color state
                    homeKitManager.toggleDevice(accessory)
                } label: {
                    IconButton(imageName: "lightbulb.fill", tint: isOn ? .yellow : .white) // Change tint based on state
                }
                .buttonStyle(.plain)
                
                Text("LightBulb")
                    .font(.largeTitle)
            }
            .frame(minWidth: 300, minHeight: 200)
            .padding()
            .onAppear {
                // If we haven't yet set currentAccessory, set it from the global manager once
                if currentAccessory == nil {
                    currentAccessory = selectedAccessoryManager.selectedAccessory
                }
            }
        } else {
            Text("No Accessory Selected")
                .frame(minWidth: 300, minHeight: 200)
                .onAppear {
                    // On first appear, if we have no accessory, try to set it
                    if currentAccessory == nil {
                        currentAccessory = selectedAccessoryManager.selectedAccessory
                    }
                }
        }
    }
}

struct IconButton: View {
    let imageName: String
    var tint: Color
    
    var body: some View {
        Circle()
            .fill(Color.white.opacity(0.2)) // Semi-transparent circle background
            .frame(width: 120, height: 120)
            .overlay(
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(tint) // Use the tint color
                    .frame(width: 60, height: 60)
            )
    }
}
