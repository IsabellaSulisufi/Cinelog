//
//  HomeViewModelTests.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 02/09/2026.
//

import Testing
import Foundation

@testable import Cinelog

struct HomeViewModelTests {

    struct HomeViewModelLoadPopularFilms {
        @MainActor
        @Test func test_loadPopularFilms_success() async throws {
            let mock = MockMovieService()
            mock.popularFilmsResult = .success(watchedFilms)
            
            let sut = HomeViewModel(service: mock)
            
            await sut.loadPopularFilms()
            
            #expect(sut.popularFilms.map(\.id) == watchedFilms.map(\.id))
            #expect(sut.errorMessage == nil)
        }
        
        @MainActor
        @Test func test_loadPopularFilms_noInternet() async throws {
            let mock = MockMovieService()
            mock.popularFilmsResult = .failure(URLError(.notConnectedToInternet))
            let sut = HomeViewModel(service: mock)

            await sut.loadPopularFilms()

            #expect(sut.errorMessage == "No internet connection. Check your connection and try again.")
            #expect(sut.popularFilms.map(\.id).isEmpty)
        }
        
        @MainActor
        @Test func test_loadPopularFilms_genericError() async throws {
            let mock = MockMovieService()
            mock.popularFilmsResult = .failure(NetworkError.invalidData)
            let sut = HomeViewModel(service: mock)

            await sut.loadPopularFilms()

            #expect(sut.errorMessage == "Something went wrong. Please try again later.")
            #expect(sut.popularFilms.map(\.id).isEmpty)
        }
    }
    
    struct HomeViewModelLoadNowPlayingInCinemaFilms {
        @MainActor
        @Test func test_loadNowPlayingFilms_success() async throws {
            let mock = MockMovieService()
            mock.nowPlayingFilmsResult = .success(watchedFilms)
            
            let sut = HomeViewModel(service: mock)
            
            await sut.loadNowPlayingInCinemaFilms()

            #expect(sut.nowPlayingInCinemaFilms.map(\.id) == watchedFilms.map(\.id))
            #expect(sut.errorMessage == nil)
        }
        
        @MainActor
        @Test func test_loadNowPlayingFilms_noInternet() async throws {
            let mock = MockMovieService()
            mock.nowPlayingFilmsResult = .failure(URLError(.notConnectedToInternet))
            let sut = HomeViewModel(service: mock)

            await sut.loadNowPlayingInCinemaFilms()

            #expect(sut.errorMessage == "No internet connection. Check your connection and try again.")
            #expect(sut.nowPlayingInCinemaFilms.map(\.id).isEmpty)
        }
        
        @MainActor
        @Test func test_loadNowPlayingFilms_genericError() async throws {
            let mock = MockMovieService()
            mock.nowPlayingFilmsResult = .failure(NetworkError.invalidData)
            let sut = HomeViewModel(service: mock)

            await sut.loadNowPlayingInCinemaFilms()

            #expect(sut.errorMessage == "Something went wrong. Please try again later.")
            #expect(sut.nowPlayingInCinemaFilms.map(\.id).isEmpty)
        }
    }
}
