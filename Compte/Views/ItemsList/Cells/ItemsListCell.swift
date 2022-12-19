//
//  ItemsListCell.swift
//  Compte
//
//  Created by likeadeveloper on 19/12/22.
//

import SwiftUI

struct ItemsListCell: View {
    @State var model: CompteObject
    var deleteAction: ((UUID) -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            Text(model.name)
                .font(.title)
                .fontDesign(.monospaced)
            Text(model.dateFormatted,
                 format: Date
                .FormatStyle()
                .year()
                .month()
                .day()
                .locale(Locale.current))
            .font(.subheadline)
            .fontDesign(.serif)
        }
        .swipeActions(allowsFullSwipe: true) {
            Button(role: .destructive) {
                withAnimation {
                    deleteAction?(model.id)
                }
            } label: {
                Text("Delete")
            }
        }
    }
}

struct ItemsListCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = CompteObject(id: nil,
                                 date: Date().timeIntervalSince1970,
                                 name: "test")
        ItemsListCell(model: model)
    }
}
