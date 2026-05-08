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

class FilmClass: ObservableObject {
    @Published var popularFilms: [FilmDetails] = []

    func loadPopularFilms() async {
        do {
            popularFilms = try await getPopularFilms().results
        } catch {
            print(error)
        }
    }

    func getPopularFilms() async throws -> PopularFilmsResponse {

        let endpoint = "https://api.themoviedb.org/3/movie/popular"

        guard let url = URL(string: endpoint) else {
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
            return try decoder.decode(PopularFilmsResponse.self, from: data)

        // if this fails it is because it doesn't match the model names correctly
        } catch {
            throw NetworkError.invalidData
        }
    }
}
