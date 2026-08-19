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
    private let service = MovieService()

    func loadFilmDetails(id: Int) async {
        do {
            filmDetails = try await service.fetchFilmDetail(id: id)
        } catch {
            print(error)
        }
    }
}
