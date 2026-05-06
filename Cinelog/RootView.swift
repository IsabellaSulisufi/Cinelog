//
//  RootView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 12/03/2026.
//

import SwiftUI

// MARK: - Root Content View with TabView
struct RootView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            MovieSearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)

            MyFilmsView()
                .tabItem {
                    Label("My Films", systemImage: "book.pages")
                }
                .tag(2)
        }
        .accentColor(.blue) // Active tab icon color
    }
}

// MARK: - Preview
#Preview {
    RootView()
}
