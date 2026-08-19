//
//  WatchedFilmSection.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 19/08/2026.
//

import SwiftUI

struct WatchedFilmSection: View {
    let watchedFilm: WatchedFilm

    var body: some View {
        let film = watchedFilm.film
        NavigationLink(destination: FilmDetailView(filmId: film.id)) {
            HStack(alignment: .top) {
                VStack {
                    FilmImageView(posterPath: film.posterPath ?? "", width: 96, height: 144)
                }
                .padding(.trailing, 14)

                VStack(alignment: .leading) {
                    Text(film.title)
                        .font(.custom("CormorantGaramond-Regular", size: 22))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 4)

                    HStack {
                        Text(String(film.releaseDate.prefix(4)))
                            .foregroundColor(Color("Font"))
                            .font(.system(size: 12))

                        Text(film.runtime?.toHoursAndMinutes() ?? "")
                            .foregroundColor(Color("Font"))
                            .font(.system(size: 12))
                    }

                    HStack(spacing: 8) {
                        ForEach((film.genres ?? []).prefix(2), id: \.id) { genre in
                            GenrePillView(name: genre.name, fontColor: "Font")
                        }
                    }
                    .padding(.bottom, 8)

                    HStack(spacing: 8) {
                        RatingPillView(score: film.voteAverage, scoreFontSize: 16, totalFontSize: 14)

                        Text("Watched \(watchedFilm.dateWatched.formatted(date: .abbreviated, time: .omitted))")
                            .foregroundColor(Color("Font"))
                            .font(.system(size: 12))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 24)
        }
        .buttonStyle(.plain)
        .padding(.bottom, 16)
    }
}
