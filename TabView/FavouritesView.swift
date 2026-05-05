//
//  FavouritesView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct FavouritesView: View {
    let items = ["SwiftUI", "Combine", "UIKit", "CoreData", "CloudKit"]

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text(item)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
