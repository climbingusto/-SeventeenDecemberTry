//
//  SectionView.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import SwiftUI
import HomeKit

struct SectionView: View {
    let title: String
    let accessories: [HMAccessory]
    let icon: String

    @EnvironmentObject var homeKitManager: HomeKitManager
    @EnvironmentObject var selectedAccessoryManager: SelectedAccessoryManager

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 20) {
                ForEach(accessories, id: \.uniqueIdentifier) { accessory in
                    AccessoryButtonView(accessory: accessory, icon: icon)
                }
            }
        }
    }
}
