//
//  FilmModel.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 06/05/2026.
//

import Foundation

struct FilmDetail: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let genreIds: [Int]?
    let runtime: Int?
    let genres: [Genre]?
    let overview: String?
    let tagline: String?
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct FilmsResponse: Codable {
    let results: [FilmDetail]
}

struct WatchedFilm: Codable {
    let film: FilmDetail
    let scoreRating: Int
    let dateWatched: Date
    let locationWatched: String
    let watchedWith: String
    let emotionFelt: [String]
}
