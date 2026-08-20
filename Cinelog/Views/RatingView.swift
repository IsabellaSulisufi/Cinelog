//
//  RatingView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 08/06/2026.
//

import SwiftUI

struct RatingView: View {
    @StateObject private var viewModel: RatingViewModel
    let film: FilmDetail
    @State private var watchedDate = Date.now
    @State private var selectedLocation: String = ""
    @State private var withText: String = ""
    @State private var selectedFeelings: Set<String> = []
    @State private var selectedScore: Int?
    @Environment(\.dismiss) var dismiss

    init(film: FilmDetail, store: WatchedFilmsStore) {
        self.film = film
        _viewModel = StateObject(wrappedValue: RatingViewModel(store: store))
    }

    private let feelingIcons: [String: String] = [
        "Wept": "drop", "Rewatch": "arrow.clockwise", "Slow burn": "flame",
        "Cosy": "cup.and.saucer", "Shaken": "waveform.path.ecg", "Inspired": "lightbulb",
        "Underwhelmed": "hand.thumbsdown", "Left thinking": "brain",
        "Fell asleep": "moon.zzz", "Breathtaking": "sparkles"
    ]

    private let locationIcons: [String: String] = [
        "Cinema": "ticket", "Home": "house", "Travelling": "airplane.up.right",
        "Friend's": "person.2", "Other": "mappin"
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
                                SingleSelectChips(options: ["Cinema", "Home", "Travelling"], selection: $selectedLocation) { name, isSelected in
                                    ChipView(icon: locationIcons[name] ?? "circle", name: name, isSelected: isSelected)
                                }
                            }
                            HStack(spacing: 8) {
                                SingleSelectChips(options: ["Friend's", "Other"], selection: $selectedLocation) { name, isSelected in
                                    ChipView(icon: locationIcons[name] ?? "circle", name: name, isSelected: isSelected)
                                }
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
                        viewModel.rate(
                            film: film,
                            score: selectedScore,
                            date: watchedDate,
                            location: selectedLocation,
                            with: withText,
                            feelings: selectedFeelings)
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

struct SingleSelectChips<Content: View>: View {
    let options: [String]
    @Binding var selection: String
    @ViewBuilder let content: (String, Bool) -> Content

    var body: some View {
        ForEach(options, id: \.self) { option in
            Button {
                selection = (selection == option) ? "" : option
            } label: {
                content(option, selection == option)
            }
            .buttonStyle(.plain)
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
    RatingView(film: FilmDetail(id: 594767, title: "Sinners", posterPath: nil, releaseDate: "2025-04-18", voteAverage: 7.5, voteCount: 1000, genreIds: nil, runtime: 137, genres: nil, overview: nil, tagline: nil), store: WatchedFilmsStore())
}
