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
    @Published var errorMessage: String?

    private let service = MovieService()

    func loadPopularFilms() async {
        errorMessage = nil
        do {
            popularFilms = try await service.fetchPopularFilms()
        } catch let error as URLError {
            errorMessage = "No internet connection. Check your connection and try again."
        } catch {
            errorMessage = "Something went wrong. Please try again later."
        }
    }

    func loadNowPlayingInCinemaFilms() async {
        errorMessage = nil
        do {
            nowPlayingInCinemaFilms = try await service.fetchNowPlayingInCinemaFilms()
        } catch let error as URLError {
            errorMessage = "No internet connection. Check your connection and try again."
        } catch {
            errorMessage = "Something went wrong. Please try again later."
        }
    }
}
