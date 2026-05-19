//
//  MovieSearchView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct MovieSearchView: View {
    @State private var searchTerm = ""
    @StateObject var viewModel = FilmClass()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.searchResults.isEmpty {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    Text("Search for something!")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            ForEach(viewModel.searchResults, id: \.id) { film in
                                NavigationLink(destination: FilmDetailView(filmId: film.id)) {
                                    VStack {
                                        AsyncImage(url: URL(
                                            string: "https://image.tmdb.org/t/p/w500\(film.posterPath ?? "")")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Rectangle()
                                                .foregroundColor(Color.gray.opacity(0.3))
                                        }
                                        .frame(height: 160)
                                        .cornerRadius(8)
                                        Text(film.title)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 11))
                                            .lineLimit(2)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchTerm, placement: .toolbar, prompt: "Search films, directors, genres")
            .onChange(of: searchTerm) {
                Task {
                    await viewModel.loadSearchedFilmResult(searchedFilm: searchTerm)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MovieSearchView()
}
