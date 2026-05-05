//
//  ContentView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 12/03/2026.
//

import SwiftUI

// MARK: - Root Content View with TabView
struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)

            FavouritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .accentColor(.blue) // Active tab icon color
    }
}


// MARK: - Preview
#Preview {
    ContentView()
}
