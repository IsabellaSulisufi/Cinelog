//
//  FilmImageView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 04/08/2026.
//

import SwiftUI

struct FilmImageView: View {
    let posterPath: String
    var width: CGFloat?
    let height: CGFloat
    var contentMode: ContentMode = .fill

    var body: some View {
        AsyncImage(url: URL(
            string: "https://image.tmdb.org/t/p/w500\(posterPath)"
        )) { image in
            image
                .resizable()
            .aspectRatio(contentMode: contentMode)
        } placeholder: {
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.3))
        }
        .frame(width: width, height: height)
        .cornerRadius(8)
    }
}
