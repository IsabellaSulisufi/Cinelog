//
//  RatingViewModelTests.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 02/09/2026.
//

import Testing
import Foundation

@testable import Cinelog

struct RatingViewModelTests {

    @MainActor
    @Test func test_rate_marksFilmAsWatched() async throws {
        let store = WatchedFilmsStore()
        let sut = RatingViewModel(store: store)
        let film = watchedFilms[0]
        let date = Date(timeIntervalSince1970: 0)

        sut.rate(film: film, score: 8, date: date, location: "Home", with: "Friends", feelings: ["Happy"])

        #expect(store.isWatched(film.id))
        #expect(store.watchedFilms.count == 1)
        #expect(store.watchedFilms.first?.scoreRating == 8)
        #expect(store.watchedFilms.first?.locationWatched == "Home")
        #expect(store.watchedFilms.first?.watchedWith == "Friends")
    }

    @MainActor
    @Test func test_rate_noScore_defaultsToZero() async throws {
        let store = WatchedFilmsStore()
        let sut = RatingViewModel(store: store)
        let film = watchedFilms[0]
        let date = Date(timeIntervalSince1970: 0)

        sut.rate(film: film, score: nil, date: date, location: "Home", with: "Friends", feelings: [])

        #expect(store.watchedFilms.first?.scoreRating == 0)
    }
}
