//
//  MovieService.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 27/07/2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case invalidCall
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

struct MovieService {
    func fetchPopularFilms() async throws -> [FilmDetail] {
        try await fetchFilms(endpoint: "movie/popular")
    }

    func fetchNowPlayingInCinemaFilms() async throws -> [FilmDetail] {
        try await fetchFilms(endpoint: "movie/now_playing")
    }

    func fetchTopRatedFilms() async throws -> [FilmDetail] {
        try await fetchFilms(endpoint: "movie/top_rated")
    }

    func searchFilms(query: String) async throws -> [FilmDetail] {
        try await fetchFilms(endpoint: "search/movie?query=\(query)")
    }

    func fetchFilmDetail(id: Int) async throws -> FilmDetail {
        try await makeAPIRequest(endpoint: "movie/\(id)")   // different shape — single object, not .results
    }

    // the one place the repeated "call it, unwrap .results" logic lives
    private func fetchFilms(endpoint: String) async throws -> [FilmDetail] {
        let response: FilmsResponse = try await makeAPIRequest(endpoint: endpoint)
        return response.results
    }
}
