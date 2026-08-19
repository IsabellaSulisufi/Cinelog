//
//  MyFilmsView.swift
//  TabView
//
//  Created by Isabella Sulisufi on 13/03/2026.
//

import SwiftUI

struct MyFilmsView: View {
    @EnvironmentObject var watchedFilmsStore: WatchedFilmsStore

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("My Films")
                    .font(.custom("CormorantGaramond-Regular", size: 36))
                    .padding(.bottom, 4)
                    .padding(.leading, 24)

                HStack {
                    Text("\(watchedFilmsStore.watchedFilms.count) films")
                        .foregroundColor(Color("Font"))
                        .font(.system(size: 12))
                }
                .padding(.bottom, 30)
                .padding(.leading, 24)

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(watchedFilmsStore.watchedFilms.prefix(5), id: \.film.id) { watchedFilm in
                            WatchedFilmSection(watchedFilm: watchedFilm)
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
        .environmentObject(WatchedFilmsStore())
}
