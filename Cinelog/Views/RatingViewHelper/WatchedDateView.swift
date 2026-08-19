//
//  WatchedDateView.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 19/08/2026.
//

import SwiftUI

struct WatchedDateView: View {
    @State private var viewOpen = false
    @Binding var date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("When")
                .foregroundColor(Color("Accent"))
                .textCase(.uppercase)
                .fontWeight(.semibold)
                .font(.system(size: 12))
                .kerning(1.2)

            VStack(spacing: 0) {
                Button(action: { viewOpen.toggle() }) {
                    HStack {
                        Image(systemName: "calendar")
                        VStack(alignment: .leading, spacing: 2) {
                            Text("WATCHED ON")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text(date, style: .date)
                        }
                        Spacer()
                        Image(systemName: viewOpen ? "chevron.up" : "chevron.down")
                    }
                    .padding()
                }
                .buttonStyle(.plain)

                if viewOpen {
                    Divider()
                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 8)
                        .onChange(of: date) { viewOpen = false }
                }
            }
            .background(Color("LightGrey"))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .padding(.bottom, 10)
    }
}
