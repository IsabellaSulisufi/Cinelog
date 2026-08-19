//
//  MovieSearchView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject private var viewModel = MovieSearchViewModel()
     @State private var searchTerm = ""

    let genres = ["Action", "Comedy", "Drama", "Horror", "Romance", "Thriller", "Animation", "Sci-Fi", "Documentary"]

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if viewModel.searchResults.isEmpty {
                    ScrollView {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Trending Genres")
                                    .textCase(.uppercase)
                                    .fontWeight(.heavy)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("Accent"))
                                HStack {
                                    ForEach(genres.shuffled().prefix(5), id: \.self) { genre in
                                        ChipView(icon: nil, name: genre)
                                    }
                                }
                                .padding(.bottom, 20.0)
                            }

                            Text("Top Rated")
                                .textCase(.uppercase)
                                .fontWeight(.heavy)
                                .font(.system(size: 14))
                                .foregroundColor(Color("Accent"))

                            FilmGridSection(films: viewModel.topRatedFilms)
                        }
                        .padding(.horizontal, 5)
                        .padding(.top, 15)
                    }
                    .padding(.horizontal, 10.0)

                } else {
                    ScrollView {
                        FilmGridSection(films: viewModel.searchResults)
                        .padding(.horizontal, 12)
                    }
                }
            }
            .background(Color("Background"))
            .navigationTitle("Search")
            .searchable(text: $searchTerm, placement: .toolbar, prompt: "Search films, directors, genres")
            .onChange(of: searchTerm) {
                Task {
                    await viewModel.search(searchTerm)
                }
            }
            .task {
                await viewModel.loadTopRatedFilms()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    MovieSearchView()
}
