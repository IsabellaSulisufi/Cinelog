//
//  HomeView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: FilmClass
    let genreNames = [28: "Action", 35: "Comedy", 18: "Drama", 27: "Horror", 10749: "Romance", 878: "Sci-Fi", 12: "Adventure", 16: "Animation", 53: "Thriller", 80: "Crime", 9648: "Mystery", 10751: "Family", 14: "Fantasy", 36: "History", 10402: "Music", 99: "Documentary"]



    var body: some View {
        NavigationView {
            VStack {
                Text("Cinelog")
                    .font(.custom("CormorantGaramond-BoldItalic", size: 36))
                
                VStack (alignment: .leading) {
                    Text("In Rotation")
                        .textCase(.uppercase)
                        .fontWeight(.heavy)
                        .font(.system(size: 12))
                        .foregroundColor(Color("Accent"))
                        .padding(.bottom, 1)
                    
                    Text("Popular right now")
                        .font(.custom("CormorantGaramond-Regular", size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                // Popular Films
                ScrollView(.horizontal) {
                    HStack {
                        if viewModel.popularFilms.isEmpty {
                            Text("Loading...")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        } else {
                            ForEach(viewModel.popularFilms, id: \.id) { film in
                                NavigationLink(destination: FilmDetailView(filmId: film.id)) {
                                    VStack (alignment: .leading) {
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
                                            
                                            if let firstGenreId = film.genreIds?.first, let genreName = genreNames[firstGenreId] {
                                                Text(genreName)
                                                    .font(.system(size: 10))
                                                    .foregroundColor(Color("Font"))
                                            }
                                        }

                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.trailing, 10.0)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 20)
                
                
                
                VStack (alignment: .leading) {
                    Text("Try something new")
                        .textCase(.uppercase)
                        .fontWeight(.heavy)
                        .font(.system(size: 12))
                        .foregroundColor(Color("Accent"))
                        .padding(.bottom, 1)
                    
                    Text("Now Playing in Cinemas")
                        .font(.custom("CormorantGaramond-Regular", size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal) {
                    HStack {
                        if viewModel.nowPlayingInCinemaFilms.isEmpty {
                            Text("Loading...")
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        } else {
                            ForEach(viewModel.nowPlayingInCinemaFilms, id: \.id) { film in
                                NavigationLink(destination: FilmDetailView(filmId: film.id)) {
                                    VStack (alignment: .leading) {
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
                                            
                                            if let firstGenreId = film.genreIds?.first, let genreName = genreNames[firstGenreId] {
                                                Text(genreName)
                                                    .font(.system(size: 10))
                                                    .foregroundColor(Color("Font"))
                                            }
                                        }

                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.trailing, 10.0)
                                }
                            }
                        }
                    }
                }
                

                
                
            }
            .padding(.horizontal, 20.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .ignoresSafeArea()
            .task {
                await viewModel.loadPopularFilms()
                await viewModel.loadNowPlayingInCinemaFilms()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    HomeView()
        .environmentObject(FilmClass())
}
