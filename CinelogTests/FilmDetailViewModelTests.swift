//
//  FilmDetailViewModelTests.swift
//  CinelogTests
//
//  Created by Isabella Sulisufi on 02/09/2026.
//

import Testing
import Foundation

@testable import Cinelog

struct FilmDetailViewModelTests {
    
    @MainActor
    @Test func test_loadFilmDetailVM_success() async throws {
        let mock = MockMovieService()
        mock.filmDetailResult = .success(watchedFilms[0])
        
        let sut = FilmDetailViewModel(service: mock)

        await sut.loadFilmDetails(id: watchedFilms[0].id)

        #expect(sut.filmDetails?.id == watchedFilms[0].id)
        #expect(sut.errorMessage == nil)
    }
    
    @MainActor
    @Test func test_loadFilmDetailVM_noInternet() async throws {
        let mock = MockMovieService()
        mock.filmDetailResult = .failure(URLError(.notConnectedToInternet))
        let sut = FilmDetailViewModel(service: mock)

        await sut.loadFilmDetails(id: watchedFilms[0].id)

        #expect(sut.errorMessage == "No internet connection. Check your connection and try again.")
        #expect(sut.filmDetails == nil)
    }
    
    @MainActor
    @Test func test_loadFilmDetailVM_genericError() async throws {
        let mock = MockMovieService()
        mock.filmDetailResult = .failure(NetworkError.invalidData)
        let sut = FilmDetailViewModel(service: mock)

        await sut.loadFilmDetails(id: watchedFilms[0].id)

        #expect(sut.errorMessage == "Something went wrong. Please try again later.")
        #expect(sut.filmDetails == nil)
    }
}
