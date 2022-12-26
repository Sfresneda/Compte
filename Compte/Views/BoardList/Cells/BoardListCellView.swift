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
    var onDelete: ((UUID) -> Void)?
    var onRename: (() -> Void)?
    let decorator: BoardListCellDecorator = DefaultBoardListCellDecorator()

    // MARK: Lifecycle
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(countNumber(for: model.taps.count))
                    .font(decorator.tapsIndicatorFont)
                    .bold()
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
            .swipeActions(allowsFullSwipe: true) {
                Button(role: .destructive) {
                    withAnimation {
                        onDelete?(model.id)
                    }
                } label: {
                    Image(systemName: decorator.swipeActionDeleteImageName)
                }

                Button {
                    withAnimation {
                        onRename?()
                    }
                } label: {
                    Image(systemName: decorator.swipeActionRenameImageName)
                }
                .tint(decorator.swipeActionRenameColor)
            }
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

// MARK: - Preview
struct BoardListCell_Previews: PreviewProvider {
    static var previews: some View {
        let numberOfTaps: Int = 100
        let tapsCollection = Array(repeating: TapObject(date: Date().timeIntervalSince1970,
                                                        tapNumber: .zero),
                                   count: numberOfTaps)
        let model = CompteObject(id: nil,
                                 date: Date().timeIntervalSince1970,
                                 name: "test",
                                 taps: tapsCollection,
                                 lastModified: Date().timeIntervalSince1970)
        BoardListCellView(model: .constant(model))
    }
}
