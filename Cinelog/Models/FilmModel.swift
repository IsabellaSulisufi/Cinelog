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

extension FilmDetail {
    private static let genreNames: [Int: String] = [
        28: "Action", 35: "Comedy", 18: "Drama", 27: "Horror", 10749: "Romance",
        878: "Sci-Fi", 12: "Adventure", 16: "Animation", 53: "Thriller", 80: "Crime",
        9648: "Mystery", 10751: "Family", 14: "Fantasy", 36: "History", 10402: "Music", 99: "Documentary"
    ]

    var primaryGenreName: String? {
        guard let firstGenreId = genreIds?.first else { return nil }
        return Self.genreNames[firstGenreId]
    }
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
