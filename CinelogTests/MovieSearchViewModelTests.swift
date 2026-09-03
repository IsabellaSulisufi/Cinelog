//
//  MovieSearchViewModelTests.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 02/09/2026.
//

import Testing
import Foundation

@testable import Cinelog

struct MovieSearchViewModelTests {

    struct MovieSearchViewModelLoadTopRatedFilms {
        @MainActor
        @Test func test_loadTopRatedFilms_success() async throws {
            let mock = MockMovieService()
            mock.topRatedFilmsResult = .success(watchedFilms)
            let sut = MovieSearchViewModel(service: mock)

            await sut.loadTopRatedFilms()

            #expect(sut.topRatedFilms.map(\.id) == watchedFilms.map(\.id))
            #expect(sut.errorMessage == nil)
        }

        @MainActor
        @Test func test_loadTopRatedFilms_noInternet() async throws {
            let mock = MockMovieService()
            mock.topRatedFilmsResult = .failure(URLError(.notConnectedToInternet))
            let sut = MovieSearchViewModel(service: mock)

            await sut.loadTopRatedFilms()

            #expect(sut.errorMessage == "No internet connection. Check your connection and try again.")
            #expect(sut.topRatedFilms.isEmpty)
        }

        @MainActor
        @Test func test_loadTopRatedFilms_genericError() async throws {
            let mock = MockMovieService()
            mock.topRatedFilmsResult = .failure(NetworkError.invalidData)
            let sut = MovieSearchViewModel(service: mock)

            await sut.loadTopRatedFilms()

            #expect(sut.errorMessage == "Something went wrong. Please try again later.")
            #expect(sut.topRatedFilms.isEmpty)
        }
    }

    struct MovieSearchViewModelSearch {
        @MainActor
        @Test func test_search_success() async throws {
            let mock = MockMovieService()
            mock.searchFilmsResult = .success(watchedFilms)
            let sut = MovieSearchViewModel(service: mock)

            await sut.search("Star Wars")

            #expect(sut.searchResults.map(\.id) == watchedFilms.map(\.id))
            #expect(sut.errorMessage == nil)
        }

        @MainActor
        @Test func test_search_noInternet() async throws {
            let mock = MockMovieService()
            mock.searchFilmsResult = .failure(URLError(.notConnectedToInternet))
            let sut = MovieSearchViewModel(service: mock)

            await sut.search("Star Wars")

            #expect(sut.errorMessage == "No internet connection. Check your connection and try again.")
            #expect(sut.searchResults.isEmpty)
        }

        @MainActor
        @Test func test_search_genericError() async throws {
            let mock = MockMovieService()
            mock.searchFilmsResult = .failure(NetworkError.invalidData)
            let sut = MovieSearchViewModel(service: mock)

            await sut.search("Star Wars")

            #expect(sut.errorMessage == "Something went wrong. Please try again later.")
            #expect(sut.searchResults.isEmpty)
        }
    }
}
