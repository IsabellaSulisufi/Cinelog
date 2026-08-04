//
//  HomeViewModel.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 27/07/2026.
//

import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var popularFilms: [FilmDetail] = []
    @Published var nowPlayingInCinemaFilms: [FilmDetail] = []
    
    let genreNames = [28: "Action", 35: "Comedy", 18: "Drama", 27: "Horror", 10749: "Romance", 878: "Sci-Fi", 12: "Adventure", 16: "Animation", 53: "Thriller", 80: "Crime", 9648: "Mystery", 10751: "Family", 14: "Fantasy", 36: "History", 10402: "Music", 99: "Documentary"]
    
    func primaryGenreName(for film: FilmDetail) -> String? {
        guard let firstGenreId = film.genreIds?.first else { return nil }
        return genreNames[firstGenreId]
    }

    private let service = MovieService()          

    func loadPopularFilms() async {
        do {
            popularFilms = try await service.fetchPopularFilms()   // ← calls it
        } catch {
            print(error)
        }
    }

    func loadNowPlayingInCinemaFilms() async {
        do {
            nowPlayingInCinemaFilms = try await service.fetchNowPlayingInCinemaFilms()
        } catch {
            print(error)
        }
    }
}
