//
//  MockMovieService.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 02/09/2026.
//

import Foundation

@testable import Cinelog
final class MockMovieService: MovieServiceProtocol {
    var filmDetailResult: Result<FilmDetail, Error> = .failure(NetworkError.invalidData)
    var popularFilmsResult: Result<[FilmDetail], Error> = .failure(NetworkError.invalidData)
    var nowPlayingFilmsResult: Result<[FilmDetail], Error> = .failure(NetworkError.invalidData)
    var topRatedFilmsResult: Result<[FilmDetail], Error> = .failure(NetworkError.invalidData)
    var searchFilmsResult: Result<[FilmDetail], Error> = .failure(NetworkError.invalidData)

    func fetchFilmDetail(id: Int) async throws -> FilmDetail {
        try filmDetailResult.get()
    }

    func fetchPopularFilms() async throws -> [FilmDetail] { try popularFilmsResult.get() }
    func fetchNowPlayingInCinemaFilms() async throws -> [FilmDetail] { try nowPlayingFilmsResult.get() }
    func fetchTopRatedFilms() async throws -> [FilmDetail] { try topRatedFilmsResult.get() }
    func searchFilms(query: String) async throws -> [FilmDetail] { try searchFilmsResult.get() }
}
