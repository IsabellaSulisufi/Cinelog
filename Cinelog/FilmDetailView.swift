//
//  FilmDetailViewH.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct FilmDetailView: View {
    @StateObject var viewModel = FilmClass()
    let filmId: Int

    var body: some View {
        ScrollView {
            if let film = viewModel.filmDetails {
                VStack(spacing: 10) {

                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath ?? "")")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 300)
                            .cornerRadius(12)
                            .padding(.bottom, 40)
                    } placeholder: {
                        Rectangle()
                            .frame(width: 180, height: 260)
                            .cornerRadius(12)
                    }

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
                            .foregroundColor((Color("Font")))
                            .font(.system(size: 12))

                        Text(film.runtime?.toHoursAndMinutes() ?? "")
                            .foregroundColor(Color("Font"))
                                .font(.system(size: 12))
                    }
//

                    HStack(spacing: 12) {
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
                    .padding(.bottom, 20)

                    Divider()
                        .overlay(Color("LightGrey"))

                    HStack(spacing: 20) {
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

                    VStack(alignment: .leading) {
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
                    .padding(.top, 10)
                    .padding(.horizontal, 20)

                    Spacer()
                }

            } else {
                Text("Loading")
            }

        }
//        .padding(.horizontal, 20)
        .background(Color("Background"))
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            await viewModel.loadFilmDetail(id: filmId)
        }
    }
}

// MARK: - Preview
#Preview {
    FilmDetailView(filmId: 594767)
}

extension Int {
    func toHoursAndMinutes() -> String {
        let hours = self / 60
        let minutes = self % 60
        return "\(hours)h \(minutes)m"
    }
}
