//
//  ScorePickerView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 19/08/2026.
//

import SwiftUI

struct ScorePickerView: View {
    @Binding var selectedScore: Int?
    let total: Int = 10

    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Score")
                .foregroundColor(Color("Accent"))
                .textCase(.uppercase)
                .fontWeight(.semibold)
                .font(.system(size: 12))
                .kerning(1.2)

            HStack(spacing: 6) {
                ForEach(1 ... total, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill((selectedScore ?? 0) >= index ? Color("Accent") : Color("LightGrey"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .frame(width: 28, height: 28)
                        .onTapGesture {
                            // Tap same score to deselect
                            if selectedScore == index {
                                selectedScore = nil
                            } else {
                                selectedScore = index
                            }
                        }
                }
            }

            HStack(spacing: 4) {
                Text(selectedScore.map { "\($0)" } ?? "—")
                    .font(.custom("CormorantGaramond-Italic", size: 26))
                    .foregroundColor(selectedScore != nil ? Color("Accent") : .secondary)
                Text("/ \(total)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if let score = selectedScore {
                    Text("· \(scoreLabel(for: score))")
                        .foregroundColor(Color("Font"))
                        .font(.custom("CormorantGaramond-Italic", size: 16))
                } else {
                    Text("tap to score")
                        .italic()
                        .foregroundColor(Color("Font"))
                        .font(.system(size: 12))
                        .padding(.leading, 4)
                }
            }
        }
    }
    
    func scoreLabel(for score: Int) -> String {
        switch score {
        case 1: return "hated it"
        case 2: return "not for me"
        case 3: return "forgettable"
        case 4: return "had its moments"
        case 5: return "it was fine"
        case 6: return "pretty good"
        case 7: return "really enjoyed it"
        case 8: return "loved it"
        case 9: return "loved it"
        case 10: return "a masterpiece"
        default: return "okay i guess"
        }
    }
}




