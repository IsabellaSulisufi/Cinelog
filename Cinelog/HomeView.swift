//
//  HomeView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "house.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                Text("Welcome Home!")
                    .font(.title)
                    .fontWeight(.bold)
                Text("This is the Home tab.")
                    .foregroundColor(.secondary)

                // NavigationLink wraps a button-like view and pushes
                // DetailView onto the navigation stack when tapped
                NavigationLink(destination: FilmDetailView()) {
                    Label("Go to Film Details", systemImage: "arrow.right.circle.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Home")
        }
    }
}
