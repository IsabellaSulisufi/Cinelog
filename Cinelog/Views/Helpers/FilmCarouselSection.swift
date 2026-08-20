//
//  FilmCarouselSection.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 19/08/2026.
//

import SwiftUI

struct FilmCarouselSection: View {
    let title: String
    let subtitle: String
    let films: [FilmDetail]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .textCase(.uppercase)
                .fontWeight(.heavy)
                .font(.system(size: 12))
                .foregroundColor(Color("Accent"))
                .padding(.bottom, 1)

            Text(subtitle)
                .font(.custom("CormorantGaramond-Regular", size: 20))
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                if films.isEmpty {
                    Text("Loading...")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                } else {
                    ForEach(films, id: \.id) { film in
                        NavigationLink(destination: FilmDetailView(filmId: film.id)) {
                            VStack(alignment: .leading) {
                                FilmImageView(posterPath: film.posterPath ?? "", width: 96, height: 144)

                                Text(film.title)
                                    .font(.custom("CormorantGaramond-Regular", size: 14))
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)

                                HStack(spacing: 3) {
                                    Text(String(film.releaseDate.prefix(4)))
                                        .font(.system(size: 10))
                                        .foregroundColor(Color("Font"))
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Text("·")                                              .foregroundColor(Color("Font"))

                                    if let genreName = film.primaryGenreName {
                                        Text(genreName)
                                            .font(.system(size: 10))
                                            .foregroundColor(Color("Font"))
                                    }
                                }

                            }
                            .frame(width: 96, alignment: .leading)
                            .padding(.trailing, 10.0)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 20)

    }
}
