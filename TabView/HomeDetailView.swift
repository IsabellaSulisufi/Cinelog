//
//  HomeDetailView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct HomeDetailView: View {
    let features = [
        ("star.fill",       "Starred Items",  "Your top picks in one place.",   Color.yellow),
        ("bell.fill",       "Notifications",  "Stay up to date.",               Color.orange),
        ("clock.fill",      "Recent Activity","See what you've been up to.",     Color.purple),
    ]

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.fill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .padding(.top, 20)

            Text("Here are some details!")
                .font(.title2)
                .fontWeight(.semibold)

            Text("You navigated here from the Home tab using a NavigationLink.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // A list of feature cards to make the page feel real
            VStack(spacing: 12) {
                ForEach(features, id: \.0) { icon, title, subtitle, color in
                    HStack(spacing: 16) {
                        Image(systemName: icon)
                            .font(.title2)
                            .foregroundColor(color)
                            .frame(width: 36)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(title).fontWeight(.semibold)
                            Text(subtitle).font(.caption).foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
