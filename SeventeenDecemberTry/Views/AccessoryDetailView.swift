//
//  AccessoryDetailView.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import SwiftUI
import HomeKit

struct AccessoryDetailView: View {
    @EnvironmentObject var selectedAccessoryManager: SelectedAccessoryManager
    @EnvironmentObject var homeKitManager: HomeKitManager

    // A local state variable that holds the accessory this window is dedicated to
    @State private var currentAccessory: HMAccessory? = nil

    var body: some View {
        if let accessory = currentAccessory {
            let isOn = homeKitManager.deviceStates[accessory.uniqueIdentifier] ?? false
            
            VStack(spacing: 20) {
                Text("Accessory Details")
                    .font(.largeTitle)
                    .padding()
                
                Text("Name: \(accessory.name)")
                    .font(.title2)
                
                if let rm = accessory.room {
                    Text("Room: \(rm.name)")
                        .font(.headline)
                }
                
                // Current State
                HStack {
                    Text("Current State:")
                        .font(.headline)
                    Text(isOn ? "On" : "Off")
                        .font(.headline)
                        .foregroundColor(isOn ? .green : .red)
                }
                
                // Toggle Button
                Button(action: {
                    homeKitManager.toggleDevice(accessory)
                }) {
                    Text(isOn ? "Turn Off" : "Turn On")
                        .foregroundColor(.white)
                        .padding()
                        .background(isOn ? Color.red : Color.green)
                        .cornerRadius(8)
                }
                
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
