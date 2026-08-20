//
//  FilmDetailView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct FilmDetailView: View {
    @StateObject private var viewModel = FilmDetailViewModel()
    @EnvironmentObject var watchedFilmsStore: WatchedFilmsStore
    @State private var showAlertSheet = false
    @State private var showRatingSheet = false
    @Environment(\.dismiss) var dismiss
    let filmId: Int

    var body: some View {
        VStack {
            ScrollView {
                if let film = viewModel.filmDetails {
                    VStack(spacing: 10) {
                        FilmImageView(posterPath: film.posterPath ?? "", width: 200, height: 300, contentMode: .fit)
                        Text(film.title)
                            .font(.custom("CormorantGaramond-Italic", size: 26))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 6)

                        if let tagline = film.tagline, !tagline.isEmpty {
                            Text(tagline)
                                .foregroundColor(Color("Font"))
                                .font(.system(size: 12))
                                .padding(.bottom, 0)
                        }

                        HStack {
                            Text(String(film.releaseDate.prefix(4)))
                                .foregroundColor(Color("Font"))
                                .font(.system(size: 12))

                            Text(film.runtime?.toHoursAndMinutes() ?? "")
                                .foregroundColor(Color("Font"))
                                .font(.system(size: 12))
                        }

                        HStack(spacing: 12) {
                            ForEach((film.genres ?? []).prefix(2), id: \.id) { genre in
                                GenrePillView(name: genre.name, fontColor: "Accent")
                            }
                        }
                        .padding(.bottom, 20)

                        Divider()
                            .overlay(Color("LightGrey"))

                        HStack(spacing: 20) {
                            RatingPillView(score: film.voteAverage, scoreFontSize: 26, totalFontSize: 12)

                            Text("\(film.voteCount) votes")
                                .foregroundColor(Color("Font"))
                                .font(.system(size: 10))
                        }
                        Divider()
                            .overlay(Color("LightGrey"))

                        VStack(alignment: .leading) {
                            Text("Overview")
                                .textCase(.uppercase)
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                                .foregroundColor(Color("Accent"))
                                .padding(.bottom, 6)

                            Text(film.overview ?? "No overview available")
                                .font(.system(size: 14))
                                .foregroundColor(Color("Font"))
                                .lineSpacing(8)
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 20)

                        Spacer()
                    }

                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(Color("Font"))
                } else {
                    Text("Loading")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                await viewModel.loadFilmDetails(id: filmId)
            }
            if let film = viewModel.filmDetails {
                Button {
                    if !watchedFilmsStore.isWatched(film.id) {
                        showRatingSheet = true

                    } else {
                        showAlertSheet = true
                    }
                } label: {
                    Text(watchedFilmsStore.isWatched(film.id) ? "Watched" : "Mark as Watched")
                        .foregroundColor(Color("Background"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("Accent"))
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                        .padding(.top, 8)
                }
                .alert("Already in My Films", isPresented: $showAlertSheet) {
                    Button("Find something new") {
                        dismiss()
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("This one's already in your collection. Time to find your next favourite?")
                }
                .sheet(isPresented: $showRatingSheet) {
                    RatingView(film: film, store: watchedFilmsStore)
                }
            }
        }

        .background(Color("Background"))
    }
}

// MARK: - Preview

#Preview {
    FilmDetailView(filmId: 594_767)
        .environmentObject(WatchedFilmsStore())
}

extension Int {
    func toHoursAndMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        return "\(hours)h \(minutes)m"
    }
}
