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
                                        Text(genre)
                                        
                                            .font(.system(size: 13))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 8)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                
                                                    .stroke(Color("LightGrey"), lineWidth: 1)
                                            )
                                    }
                                }
                                .padding(.bottom, 20.0)
                            }

                            Text("Top Rated")
                                .textCase(.uppercase)
                                .fontWeight(.heavy)
                                .font(.system(size: 14))
                                .foregroundColor(Color("Accent"))
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 15) {
                                ForEach(viewModel.topRatedFilms, id: \.id) { film in
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
                                                .font(.system(size: 12))
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.top, 15)
                    }
                    .padding(.horizontal, 10.0)

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
                    }
                }
            }
            .background(Color("Background"))
            .navigationTitle("Search")
            .searchable(text: $searchTerm, placement: .toolbar, prompt: "Search films, directors, genres")
            .onChange(of: searchTerm) {
                Task {
                    await viewModel.loadSearchedFilmResult(searchedFilm: searchTerm)
                    
                }
            }
            .task {
                await viewModel.loadTopRatedFilmResult()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MovieSearchView()
}
