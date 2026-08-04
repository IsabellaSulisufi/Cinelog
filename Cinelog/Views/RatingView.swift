//
//  RatingView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 08/06/2026.
//

import SwiftUI

struct RatingView: View {
    @EnvironmentObject var watchedFilmsStore: WatchedFilmsStore
    let film: FilmDetail
    @State private var watchedDate = Date.now
    @State private var isExpanded = false
    @State private var selectedLocation: String = ""
    @State private var withText: String = ""
    @State private var selectedFeelings: Set<String> = []
    @State private var selectedScore: Int? = nil
    @Environment(\.dismiss) var dismiss

    private let feelingOptions = [
        "Wept", "Rewatch", "Slow burn", "Cosy", "Shaken",
        "Inspired", "Underwhelmed", "Left thinking", "Fell asleep", "Breathtaking",
    ]

    private let feelingIcons: [String: String] = [
        "Wept": "drop", "Rewatch": "arrow.clockwise", "Slow burn": "flame",
        "Cosy": "cup.and.saucer", "Shaken": "waveform.path.ecg", "Inspired": "lightbulb",
        "Underwhelmed": "hand.thumbsdown", "Left thinking": "brain",
        "Fell asleep": "moon.zzz", "Breathtaking": "sparkles",
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // MOVIE DETAILS
                    HStack(alignment: .top) {
                            VStack {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(film.posterPath ?? "no poster")")) { image in
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
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 20)
                    Divider()
                        .padding(.bottom, 10)

                    // SCORE RATING
                    ScorePickerView(selectedScore: $selectedScore)
                    Divider()
                        .padding(.bottom, 10)

                    // WHEN
                    VStack(alignment: .leading, spacing: 12) {
                        Text("When")
                            .foregroundColor(Color("Accent"))
                            .textCase(.uppercase)
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .kerning(1.2)

                        VStack(spacing: 0) {
                            Button(action: { isExpanded.toggle() }) {
                                HStack {
                                    Image(systemName: "calendar")
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("WATCHED ON")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                        Text(watchedDate, style: .date)
                                    }
                                    Spacer()
                                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                }
                                .padding()
                            }
                            .buttonStyle(.plain)

                            if isExpanded {
                                Divider()
                                DatePicker("", selection: $watchedDate, in: ...Date(), displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .padding(.horizontal, 8)
                                    .onChange(of: watchedDate) { isExpanded = false }
                            }
                        }
                        .background(Color("LightGrey"))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.bottom, 10)

                    Divider()
                        .padding(.bottom, 10)

                    // WHERE
                    VStack(alignment: .leading) {
                        Text("Where")
                            .foregroundColor(Color("Accent"))
                            .textCase(.uppercase)
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .kerning(1.2)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                chip("Cinema", icon: "ticket")
                                chip("Home", icon: "house")
                                chip("Traveling", icon: "airplane.up.right")
                            }
                            HStack(spacing: 8) {
                                chip("Friend's", icon: "person.2")
                                chip("Other", icon: "mappin")
                            }
                        }
                        .padding(.bottom, 20.0)
                    }

                    Divider()
                        .padding(.bottom, 10)

                    // WITH
                    VStack(alignment: .leading) {
                        Text("With")
                            .foregroundColor(Color("Accent"))
                            .textCase(.uppercase)
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                            .kerning(1.2)

                        TextField("Alone, Friend A, Friend B...", text: $withText)
                            .font(.system(size: 16))
                            .padding(.vertical, 8)

                        Divider()
                            .padding(.bottom, 10)
                    }

                    // HOW IT FELT
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("How It Felt")
                                .foregroundColor(Color("Accent"))
                                .textCase(.uppercase)
                                .fontWeight(.semibold)
                                .font(.system(size: 12))
                                .kerning(1.2)
                            Text("optional · pick any")
                                .font(.system(size: 12))
                                .italic()
                                .foregroundColor(.secondary)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 8) {
                                MultiSelectChips(options: ["Wept", "Rewatch", "Slow burn", "Cosy"], selection: $selectedFeelings) { name, isSelected in
                                    chip(name, icon: feelingIcons[name] ?? "circle", isSelected: isSelected) {}
                                }
                            }
                            HStack(spacing: 8) {
                                MultiSelectChips(options: ["Shaken", "Inspired", "Underwhelmed"], selection: $selectedFeelings) { name, isSelected in
                                    chip(name, icon: feelingIcons[name] ?? "circle", isSelected: isSelected) {}
                                }
                            }
                            HStack(spacing: 8) {
                                MultiSelectChips(options: ["Left thinking", "Fell asleep", "Breathtaking"], selection: $selectedFeelings) { name, isSelected in
                                    chip(name, icon: feelingIcons[name] ?? "circle", isSelected: isSelected) {}
                                }
                            }
                        }
                    }
                    .padding(.bottom, 10)

                    Divider()
                        .padding(.bottom, 10)

                    Button("Rate this movie") {
                        watchedFilmsStore.markWatched(
                            film: film,
                            scoreRating: selectedScore ?? 0,
                            dateWatched: watchedDate,
                            locationWatched: selectedLocation,
                            watchedWith: withText,
                            emotionFelt: Array(selectedFeelings))
                        dismiss()

                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("Accent"))
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 40)
                    

                    
                    

                }
                .padding(.horizontal, 20)
            }
            .background(Color("Background").ignoresSafeArea())
        }
    }

    func chip(_ name: String, icon: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 13))
            Text(name)
                .font(.system(size: 13))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .lineLimit(1)
        .foregroundColor(selectedLocation == name ? .white : .primary)
        .background(selectedLocation == name ? Color("Accent") : Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("LightGrey"), lineWidth: 1)
        )
        .onTapGesture {
            selectedLocation = (selectedLocation == name) ? "" : name
        }
    }

    func chip(_ name: String, icon: String, isSelected: Bool, action _: @escaping () -> Void) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 13))
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

struct MultiSelectChips<Content: View>: View {
    let options: [String]
    @Binding var selection: Set<String>
    @ViewBuilder let content: (String, Bool) -> Content

    var body: some View {
        ForEach(options, id: \.self) { option in
            Button {
                if selection.contains(option) {
                    selection.remove(option)
                } else {
                    selection.insert(option)
                }
            } label: {
                content(option, selection.contains(option))
            }
            .buttonStyle(.plain)
        }
    }
}

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
//                        .italic()
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
//        .padding()
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

// MARK: - Preview

#Preview {
    RatingView(film: FilmDetail(id: 594767, title: "Sinners", posterPath: nil, releaseDate: "2025-04-18", voteAverage: 7.5, voteCount: 1000, genreIds: nil, runtime: 137, genres: nil, overview: nil, tagline: nil))
        .environmentObject(WatchedFilmsStore())
}
