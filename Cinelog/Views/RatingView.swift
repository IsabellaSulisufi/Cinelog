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
    @State private var selectedLocation: String = ""
    @State private var withText: String = ""
    @State private var selectedFeelings: Set<String> = []
    @State private var selectedScore: Int?
    @Environment(\.dismiss) var dismiss

    private let feelingOptions = [
        "Wept", "Rewatch", "Slow burn", "Cosy", "Shaken",
        "Inspired", "Underwhelmed", "Left thinking", "Fell asleep", "Breathtaking"
    ]

    private let feelingIcons: [String: String] = [
        "Wept": "drop", "Rewatch": "arrow.clockwise", "Slow burn": "flame",
        "Cosy": "cup.and.saucer", "Shaken": "waveform.path.ecg", "Inspired": "lightbulb",
        "Underwhelmed": "hand.thumbsdown", "Left thinking": "brain",
        "Fell asleep": "moon.zzz", "Breathtaking": "sparkles"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    // MOVIE DETAILS
                    HStack(alignment: .top) {
                            VStack {
                                FilmImageView(posterPath: film.posterPath ?? "", width: 96, height: 144)
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
                    WatchedDateView(date: $watchedDate)

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
                                ChipView(icon: "ticket", name: "Cinema", isSelected: selectedLocation == "Cinema")
                                    .onTapGesture { selectedLocation = (selectedLocation == "Cinema") ? "" : "Cinema" }
                                ChipView(icon: "house", name: "Home", isSelected: selectedLocation == "Home")
                                    .onTapGesture { selectedLocation = (selectedLocation == "Home") ? "" : "Home" }
                                ChipView(icon: "airplane.up.right", name: "Travelling", isSelected: selectedLocation == "Travelling")
                                    .onTapGesture { selectedLocation = (selectedLocation == "Travelling") ? "" : "Travelling" }
                            }
                            HStack(spacing: 8) {
                                ChipView(icon: "person.2", name: "Friend's", isSelected: selectedLocation == "Friend's")
                                    .onTapGesture { selectedLocation = (selectedLocation == "Friend's") ? "" : "Friend's" }
                                ChipView(icon: "mappin", name: "Other", isSelected: selectedLocation == "Other")
                                    .onTapGesture { selectedLocation = (selectedLocation == "Other") ? "" : "Other" }
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
                                    ChipView(icon: feelingIcons[name] ?? "circle", name: name, isSelected: isSelected)
                                }
                            }
                            HStack(spacing: 8) {
                                MultiSelectChips(options: ["Shaken", "Inspired", "Underwhelmed"], selection: $selectedFeelings) { name, isSelected in
                                    ChipView(icon: feelingIcons[name] ?? "circle", name: name, isSelected: isSelected)
                                }
                            }
                            HStack(spacing: 8) {
                                MultiSelectChips(options: ["Left thinking", "Fell asleep", "Breathtaking"], selection: $selectedFeelings) { name, isSelected in
                                    ChipView(icon: feelingIcons[name] ?? "circle", name: name, isSelected: isSelected)
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


// MARK: - Preview

#Preview {
    RatingView(film: FilmDetail(id: 594767, title: "Sinners", posterPath: nil, releaseDate: "2025-04-18", voteAverage: 7.5, voteCount: 1000, genreIds: nil, runtime: 137, genres: nil, overview: nil, tagline: nil))
        .environmentObject(WatchedFilmsStore())
}
