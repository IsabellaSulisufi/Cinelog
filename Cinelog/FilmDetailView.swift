//
//  FilmDetailViewH.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct FilmDetailView: View {
    let film: FilmDetails

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath ?? "")")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 260)
                        .cornerRadius(10)
                        .padding(.bottom, 35)
                } placeholder: {
                    Rectangle()
                        .frame(width: 180, height: 260)
                        .cornerRadius(12)
                }
                
                
                Text(film.title)
                    .font(.custom("CormorantGaramond-Italic", size: 26))
                    .fontWeight(.heavy)
                
                HStack {
                    Text("Director Name")
                        .foregroundColor((Color("Font")))
                        .font(.system(size: 12))

                    Text(String(film.releaseDate.prefix(4)))
                        .foregroundColor((Color("Font")))
                        .font(.system(size: 12))

                    Text("Time it took")
                        .foregroundColor((Color("Font")))
                        .font(.system(size: 12))

                }
                
                HStack {
                    ForEach((film.genres ?? []).prefix(2), id: \.id) { genre in
                        Text(genre.name)
                            .textCase(.uppercase)
                            .fontWeight(.heavy)
                            .font(.system(size: 12))
                            .foregroundColor(Color("Accent"))
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color("Font"), lineWidth: 1)
                            )
                            .cornerRadius(15)
                    }
                }
                
                Divider()
                    .overlay(Color("LightGrey"))


                HStack {
                    HStack {
                        Text("\(film.voteAverage, specifier: "%.1f")")
                            .fontWeight(.heavy)
                            .font(.custom("CormorantGaramond-Italic", size: 26))
                            .foregroundColor(Color("Accent"))

                        Text("/ 10")
                            .font(.system(size: 12))
                            .foregroundColor((Color("Font")))

                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 14)
                    .background(Color("Highlight"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color("Font"), lineWidth: 1)
                    )
                    .cornerRadius(30)
                    
                    Text("\(film.voteCount) votes")
                        .foregroundColor((Color("Font")))
                        .font(.system(size: 10))
                }
                Divider()
                    .overlay(Color("LightGrey"))
                
                VStack (alignment: .leading) {
                    Text("Overview")
                        .textCase(.uppercase)
                        .fontWeight(.semibold)
                        .font(.system(size: 14))
                        .foregroundColor(Color("Accent"))
                        .padding(.bottom, 6)
                    
                    Text(film.overview ?? "No overview available")
                        .font(.system(size: 14))
                        .foregroundColor((Color("Font")))
                        .lineSpacing(8)

                }
                Spacer()
            }

            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
    }
}

// MARK: - Preview
#Preview {
    FilmDetailView(film: mockFilm)
}

let mockFilm = FilmDetails(
    id: 1226863,
    title: "The Super Mario Galaxy Movie",
    posterPath: "/eJGWx219ZcEMVQJhAgMiqo8tYY.jpg",
    releaseDate: "2026-04-01",
    voteAverage: 6.7,
    voteCount: 727,
    genreIds: [10751, 35, 12, 14, 16],
    runtime: 104,
    genres: [
        Genre(id: 10751, name: "Family"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 14, name: "Fantasy"),
        Genre(id: 16, name: "Animation")
    ],
    overview: "Having thwarted Bowser's previous plot to marry Princess Peach, Mario and Luigi now face a fresh threat in Bowser Jr., who is determined to liberate his father from captivity and restore the family legacy."
)
