//
//  FilmDetailViewModel.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 04/08/2026.
//

import SwiftUI
import Combine

@MainActor
class FilmDetailViewModel: ObservableObject {
    @Published var filmDetails: FilmDetail?
    @Published var errorMessage: String?
    private let service = MovieService()

    func loadFilmDetails(id: Int) async {
        errorMessage = nil
        do {
            filmDetails = try await service.fetchFilmDetail(id: id)
        } catch let error as URLError {
            errorMessage = "No internet connection. Check your connection and try again."
        } catch {
            errorMessage = "Something went wrong. Please try again later."
        }
    }
}
