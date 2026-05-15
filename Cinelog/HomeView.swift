//
//  HomeView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = FilmClass()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {

                    HStack {
                        if viewModel.popularFilms.isEmpty {
                            Text("Loading...")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        } else {
                            ForEach(viewModel.popularFilms, id: \.id) { film in

                                NavigationLink(destination: FilmDetailView(filmId: film.id)) {
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
                                        Text(film.title)
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 96.0, height: 70.0)
                                            .lineLimit(nil)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                    .padding(.trailing, 10.0)
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 20.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .ignoresSafeArea()
            .navigationTitle("Cinelog")
            .task {
                await viewModel.loadPopularFilms()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
