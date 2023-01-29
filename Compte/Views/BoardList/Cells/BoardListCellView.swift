//
//  BoardListCell.swift
//  Compte
//
//  Created by likeadeveloper on 19/12/22.
//

import SwiftUI

// MARK: - BoardListCellView
struct BoardListCellView: View {
    // MARK: Vars
    @Binding var model: CompteObject
    let decorator: BoardListCellDecorator = DefaultBoardListCellDecorator()

    // MARK: Lifecycle
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(countNumber(for: model.taps.count))
                    .font(decorator.tapsIndicatorFont)
                    .foregroundColor(decorator.tapsIndicatorForegroundColor)
                    .multilineTextAlignment(decorator.tapsIndicatorTextAligment)
            }
            .frame(maxWidth: decorator.tapsIndicatorMaxWidth,
                   maxHeight: decorator.tapsIndicatorMaxHeight,
                   alignment: decorator.tapsIndicatorAligment)
            .padding(decorator.tapsIndicatorPadding)
            .background(decorator.tapsIndicatorBackgroundColor)
            .cornerRadius(decorator.tapsIndicatorCornerRadious)
            VStack(alignment: .leading) {
                Text(model.name)
                    .font(decorator.boardTitleFont)
                    .foregroundColor(decorator.boardForegroundColor)
                    .bold()
                    .lineLimit(decorator.boardTitleLinesLimit)

                HStack {
                    Text(model.lastModifiedDateFormatted,
                         format: decorator.lastModificationFormat)
                    .font(decorator.lastModificationFont)
                    .foregroundColor(decorator.lastModificationForegroundColor)
                }
            }
            .padding()
        }
    }
}
// MARK: - Helpers
private extension BoardListCellView {
    func countNumber(for value: Int) -> String {
        value > 99
        ? "+99"
        : String(value)
    }
}


struct ContentView: View {
    let friends = ["Antoine", "Bas", "Curt", "Dave", "Erica"]

    var body: some View {
        List {
            ForEach(friends, id: \.self) { friend in
                Text(friend)
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            print("Muting conversation")
                        } label: {
                            Label("Mute", systemImage: "bell.slash.fill")
                        }
                        .tint(.indigo)

                        Button(role: .destructive) {
                            print("Deleting conversation")
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
            }
        }
    }
}
