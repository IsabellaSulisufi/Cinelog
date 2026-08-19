//
//  RatingPillView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 13/08/2026.
//

import SwiftUI

struct RatingPillView: View {
    let score: Double
    let scoreFontSize: CGFloat
    let totalFontSize: CGFloat

    var body: some View {
        HStack {
            Text("\(score, specifier: "%.1f")")
                .fontWeight(.heavy)
                .font(.custom("CormorantGaramond-Italic", size: scoreFontSize))
                .foregroundColor(Color("Accent"))

            Text("/ 10")
                .font(.system(size: totalFontSize))
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
    }
}
