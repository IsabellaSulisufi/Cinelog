//
//  MovieSearchViewModel.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 27/07/2026.
//

import Foundation
import Combine

@MainActor
class MovieSearchViewModel: ObservableObject {
    @Published var searchResults: [FilmDetail] = []
    @Published var topRatedFilms: [FilmDetail] = []
    @Published private var searchTerm = ""

    let genres = ["Action", "Comedy", "Drama", "Horror", "Romance", "Thriller", "Animation", "Sci-Fi", "Documentary"]
    
    private let service = MovieService()

    func loadTopRatedFilms() async {
        do {
            topRatedFilms = try await service.fetchTopRatedFilms()
        } catch {
            print(error)
        }
    }

    func search(_ query: String) async {
        do {
            searchResults = try await service.searchFilms(query: query)
        } catch {
            print(error)
        }
    }
}
