//
//  SelectedAccessoryManager.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import Foundation
import HomeKit

class SelectedAccessoryManager: ObservableObject {
    @Published var selectedAccessory: HMAccessory?
}
