//
//  WatchedFilmsStore.swift
//  Cinelog
//

import Foundation
import Combine

@MainActor
class WatchedFilmsStore: ObservableObject {
    @Published private(set) var watchedFilms: [WatchedFilm] = []

    func isWatched(_ filmId: Int) -> Bool {
        watchedFilms.contains { $0.film.id == filmId }
    }

    func markWatched(
        film: FilmDetail,
        scoreRating: Int,
        dateWatched: Date,
        locationWatched: String,
        watchedWith: String,
        emotionFelt: [String]
    ) {
        watchedFilms.append(WatchedFilm(
            film: film,
            scoreRating: scoreRating,
            dateWatched: dateWatched,
            locationWatched: locationWatched,
            watchedWith: watchedWith,
            emotionFelt: emotionFelt
        ))
    }
}
