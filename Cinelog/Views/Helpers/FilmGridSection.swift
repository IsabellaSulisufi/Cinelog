//
//  FilmGridSection.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 19/08/2026.
//

import SwiftUI

struct FilmGridSection: View {
    let films: [FilmDetail]

    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 15) {
            ForEach(films, id: \.id) { film in
                NavigationLink(destination: FilmDetailView(filmId: film.id)) {
                    VStack {
                        FilmImageView(posterPath: film.posterPath ?? "", height: 160)

                        Text(film.title)
                            .foregroundColor(Color.black)
                            .font(.system(size: 12))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
        }
    }
}
