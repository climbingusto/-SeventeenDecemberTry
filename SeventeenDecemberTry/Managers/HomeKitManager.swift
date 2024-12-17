//
//  HomeKitManager.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import Foundation
import HomeKit
import SwiftUI

class HomeKitManager: NSObject, ObservableObject, HMHomeManagerDelegate {
    @Published var homes: [HMHome] = []
    @Published var selectedHome: HMHome?
    @Published var deviceStates: [UUID: Bool] = [:]
    @Published var errorMessage: ErrorMessage?

    private let homeManager = HMHomeManager()

    override init() {
        super.init()
        homeManager.delegate = self
    }

    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        homes = manager.homes
        selectedHome = manager.homes.first
    }

    func toggleDevice(_ accessory: HMAccessory) {
        guard let powerCharacteristic = accessory.services
            .flatMap({ $0.characteristics })
            .first(where: { $0.characteristicType == HMCharacteristicTypePowerState }) else { return }

        powerCharacteristic.readValue { error in
            guard error == nil, let currentValue = powerCharacteristic.value as? Bool else {
                DispatchQueue.main.async {
                    self.errorMessage = ErrorMessage(message: "Failed to read device state.")
                }
                return
            }

            let newValue = !currentValue
            powerCharacteristic.writeValue(newValue) { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.errorMessage = ErrorMessage(message: "Failed to toggle device: \(error.localizedDescription)")
                    } else {
                        self?.deviceStates[accessory.uniqueIdentifier] = newValue
                    }
                }
            }
        }
    }
}
