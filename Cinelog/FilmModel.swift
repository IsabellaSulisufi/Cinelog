//
//  FilmModel.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 06/05/2026.
//

struct FilmDetails: Codable {
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

struct PopularFilmsResponse: Codable {
    let results: [FilmDetails]
}
