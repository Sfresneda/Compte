//
//  ItemsListCell.swift
//  Compte
//
//  Created by likeadeveloper on 19/12/22.
//

import SwiftUI

struct ItemsListCell: View {
    @Binding var model: CompteObject
    var onDelete: ((UUID) -> Void)?
    var onRename: (() -> Void)?

    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(countNumber(for: model.taps.count))
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 10,
                                leading: 8,
                                bottom: 10,
                                trailing: 8))
            .background(.secondary)
            .cornerRadius(20)

            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                HStack {
                    Text(model.lastModifiedDateFormatted,
                         format: Date
                        .FormatStyle()
                        .year()
                        .month()
                        .day()
                        .locale(Locale.current))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
            }
            .swipeActions(allowsFullSwipe: true) {
                Button(role: .destructive) {
                    withAnimation {
                        onDelete?(model.id)
                    }
                } label: {
                    Image(systemName: "trash")
                }
                Button {
                    withAnimation {
                        onRename?()
                    }
                } label: {
                    Image(systemName: "pencil.line")
                }
                .tint(.blue)
            }
        }
    }
}

private extension ItemsListCell {
    func countNumber(for value: Int) -> String {
        value > 99
        ? "+99"
        : String(value)
    }
}

struct ItemsListCell_Previews: PreviewProvider {
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
        ItemsListCell(model: .constant(model))
    }
}
