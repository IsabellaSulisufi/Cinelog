//
//  ProfileView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                Text("John Doe")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("iOS Developer")
                    .foregroundColor(.secondary)

                Divider()
                    .padding(.horizontal)

                List {
                    Label("Settings", systemImage: "gear")
                    Label("Notifications", systemImage: "bell")
                    Label("Privacy", systemImage: "lock")
                    Label("Help", systemImage: "questionmark.circle")
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Profile")
        }
    }
}
