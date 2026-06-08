//
//  MyFilmsView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct MyFilmsView: View {
    @EnvironmentObject var viewModel: FilmClass
    let items = ["SwiftUI", "Combine", "UIKit", "CoreData", "CloudKit"]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("My Films")
                    .font(.custom("CormorantGaramond-Regular", size: 36))
                    .padding(.bottom, 4)
                    .padding(.leading, 24)

                HStack {
                    Text("\(viewModel.myFilms.count) films")
                        .foregroundColor(Color("Font"))
                        .font(.system(size: 12))
                }
                .padding(.bottom, 30)
                .padding(.leading, 24)

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.myFilms.prefix(5), id: \.id) { film in
                            NavigationLink(destination: FilmDetailView(filmId: film.id)) {
                                HStack(alignment: .top) {
                                    VStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath ?? "")")) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            Rectangle()
                                                .foregroundColor(Color.white)
                                        }
                                        .frame(width: 96, height: 144)
                                        .cornerRadius(8)
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
                                                Text(genre.name)
                                                    .textCase(.uppercase)
                                                    .fontWeight(.heavy)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color("Font"))
                                                    .padding(8)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 15)
                                                            .stroke(Color("Font"), lineWidth: 1)
                                                    )
                                                    .cornerRadius(15)
                                            }
                                        }
                                        .padding(.bottom, 8)

                                        HStack(spacing: 8) {
                                            HStack {
                                                Text("\(film.voteAverage, specifier: "%.1f")")
                                                    .fontWeight(.heavy)
                                                    .font(.custom("CormorantGaramond-Italic", size: 16))
                                                    .foregroundColor(Color("Accent"))

                                                Text("/ 10")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color("Font"))
                                            }
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 14)
                                            .background(Color("Highlight"))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 30)
                                                    .stroke(Color("Font"), lineWidth: 1)
                                            )
                                            .cornerRadius(30)

                                            Text("Watched April 28")
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

                            Divider()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    MyFilmsView()
        .environmentObject(FilmClass())
}
