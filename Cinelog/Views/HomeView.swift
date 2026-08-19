//
//  HomeView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text("Cinelog")
                    .font(.custom("CormorantGaramond-BoldItalic", size: 36))

                FilmCarouselSection(title: "In Rotation", subtitle: "Popular right now", films: viewModel.popularFilms)

                FilmCarouselSection(title: "Try Something New", subtitle: "Now Playing in Cinemas", films: viewModel.nowPlayingInCinemaFilms)
            }
            .padding(.horizontal, 20.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .ignoresSafeArea()
            .task {
                await viewModel.loadPopularFilms()
                await viewModel.loadNowPlayingInCinemaFilms()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
}
