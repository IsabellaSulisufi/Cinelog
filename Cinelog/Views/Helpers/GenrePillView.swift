//
//  GenrePillView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 13/08/2026.
//

import SwiftUI

struct GenrePillView: View {
    let name: String
    let fontColor: String

    var body: some View {
        Text(name)
            .textCase(.uppercase)
            .fontWeight(.heavy)
            .font(.system(size: 12))
            .foregroundColor(Color(fontColor))
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("Font"), lineWidth: 1)
            )
            .cornerRadius(15)
    }
}
