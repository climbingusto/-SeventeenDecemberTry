//
//  MainScreenView.swift
//  MultiWindowHomeKitApp
//
//  Created by YourName on DD/MM/YYYY.
//

import SwiftUI
import HomeKit

struct MainScreenView: View {
    @EnvironmentObject var homeKitManager: HomeKitManager

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select Home", selection: $homeKitManager.selectedHome) {
                    ForEach(homeKitManager.homes, id: \.uniqueIdentifier) { home in
                        Text(home.name).tag(home as HMHome?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                if let selectedHome = homeKitManager.selectedHome {
                    List(selectedHome.rooms, id: \.uniqueIdentifier) { room in
                        NavigationLink(destination: RoomDetailView(room: room)) {
                            Text(room.name)
                                .padding()
                        }
                    }
                    .navigationTitle("Rooms")
                } else {
                    Text("No homes available")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .alert(item: $homeKitManager.errorMessage) { errorMessage in
                Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
