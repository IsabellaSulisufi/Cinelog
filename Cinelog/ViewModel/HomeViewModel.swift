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
