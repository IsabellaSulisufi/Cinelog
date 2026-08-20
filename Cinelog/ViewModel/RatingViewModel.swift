//
//  RatingViewModel.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 20/08/2026.
//

import SwiftUI
import Combine

@MainActor
class RatingViewModel: ObservableObject {
    private let store: WatchedFilmsStore
    
    init(store: WatchedFilmsStore) {
        self.store = store
    }

    func rate(film: FilmDetail, score: Int?, date: Date, location: String, with: String, feelings: Set<String>) {
        store.markWatched(
            film: film,
            scoreRating: score ?? 0,
            dateWatched: date,
            locationWatched: location,
            watchedWith: with,
            emotionFelt: Array(feelings)
        )
    }
}
