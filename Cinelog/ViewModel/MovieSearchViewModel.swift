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
    @Published var errorMessage: String?

    let genres = ["Action", "Comedy", "Drama", "Horror", "Romance", "Thriller", "Animation", "Sci-Fi", "Documentary"]

    private let service: MovieServiceProtocol
    
    init(service: MovieServiceProtocol = MovieService()) {
        self.service = service
    }

    func loadTopRatedFilms() async {
        errorMessage = nil
        do {
            topRatedFilms = try await service.fetchTopRatedFilms()
        } catch let error as URLError {
            errorMessage = "No internet connection. Check your connection and try again."
        } catch {
            errorMessage = "Something went wrong. Please try again later."
        }
    }

    func search(_ query: String) async {
        errorMessage = nil
        do {
            searchResults = try await service.searchFilms(query: query)
        } catch let error as URLError {
            errorMessage = "No internet connection. Check your connection and try again."
        } catch {
            errorMessage = "Something went wrong. Please try again later."
        }
    }
}
