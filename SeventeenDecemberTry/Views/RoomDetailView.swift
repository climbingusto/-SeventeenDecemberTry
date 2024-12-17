//
//  RoomDetailView.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import SwiftUI
import HomeKit

struct RoomDetailView: View {
    let room: HMRoom
    @EnvironmentObject var homeKitManager: HomeKitManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(room.name)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                let lights = room.accessories.filter { $0.category.categoryType == HMAccessoryCategoryTypeLightbulb }
                if !lights.isEmpty {
                    SectionView(title: "Lights", accessories: lights, icon: "lightbulb")
                }

                let speakers = room.accessories.filter { $0.category.categoryType == HMAccessoryCategoryTypeSpeaker }
                if !speakers.isEmpty {
                    SectionView(title: "Speakers", accessories: speakers, icon: "speaker.2.fill")
                }
            }
            .padding()
        }
        .navigationTitle(room.name)
    }
}
