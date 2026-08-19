//
//  ChipView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 19/08/2026.
//

import SwiftUI

struct ChipView: View {
    let icon: String?
    let name: String
    var isSelected: Bool = false

    var body: some View {
        HStack(spacing: 6) {
            if let icon {
                 Image(systemName: icon)
                     .font(.system(size: 13))
             }
            Text(name)
                .font(.system(size: 13))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .lineLimit(1)
        .foregroundColor(isSelected ? .white : .primary)
        .background(isSelected ? Color("Accent") : Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("LightGrey"), lineWidth: 1)
        )
    }
}
