//
//  apifile.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 06/05/2026.
//

import Foundation
import SwiftUI
import Combine

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidCall
}

@MainActor
class FilmClass: ObservableObject {
    @Published var popularFilms: [FilmDetail] = []
    @Published var searchResults: [FilmDetail] = []
    @Published var topRatedFilms: [FilmDetail] = []
    @Published var myFilms: [FilmDetail] = []
    @Published var filmDetails: FilmDetail?
    @Published var genres = ["Action", "Comedy", "Drama", "Horror", "Romance", "Thriller", "Animation", "Sci-Fi", "Documentary"]
    
    var isWatched: Bool {
        myFilms.contains(where: { $0.id == filmDetails?.id })
    }
    
    func loadTopRatedFilmResult() async {
        do {
            let response: FilmsResponse = try await makeAPIRequest(endpoint: "movie/top_rated")
            topRatedFilms = response.results
        } catch {
            print(error)
        }
    }

    func loadPopularFilms() async {
        do {
            let response: FilmsResponse = try await makeAPIRequest(endpoint: "movie/popular")
            popularFilms = response.results
        } catch {
            print(error)
        }
    }

    func loadFilmDetail(id: Int) async {
        do {
            let response: FilmDetail = try await makeAPIRequest(endpoint: "movie/\(id)")
            filmDetails = response
        } catch {
            print(error)
        }
    }

    func loadSearchedFilmResult(searchedFilm: String) async {
        do {
            let response: FilmsResponse = try await makeAPIRequest(endpoint: "search/movie?query=\(searchedFilm)")
            searchResults = response.results
        } catch {
            print(error)
        }
    }

    func makeAPIRequest<T: Codable>(endpoint: String) async throws -> T {

        let baseURL = "https://api.themoviedb.org/3/"

        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }

        guard let token = Bundle.main.infoDictionary?["TMDBAccessToken"] as? String else {
            throw NetworkError.invalidCall
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            throw NetworkError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)

        // if this fails it is because it doesn't match the model names correctly
        } catch {
            throw NetworkError.invalidData
        }
    }
}
