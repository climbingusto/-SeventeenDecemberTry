//
//  ErrorMessage.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import Foundation

// Wrapper for error message that conforms to Identifiable
struct ErrorMessage: Identifiable {
    let id = UUID()
    let message: String
}
