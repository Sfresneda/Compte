//
//  TapListCellView.swift
//  Compte
//
//  Created by likeadeveloper on 8/12/22.
//

import SwiftUI

// MARK: - TapListCellView
struct TapListCellView: View {
    // MARK: Vars
    var model: TapObject
    let decorator: TapListCellDecorator = DefaultTapListCellDecorator()

    // MARK: Lifecycle
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                Text("\(model.tapNumber)")
                    .font(decorator.tapNumberFont)
                    .foregroundColor(decorator.tapNumberColor)
                    .bold()
                    .padding(decorator.tapNumberPadding)
            }

            VStack(alignment: .leading) {
                Text(Date(timeIntervalSince1970: model.date),
                     format: decorator.topDateStyle)
                .foregroundColor(decorator.secondaryDateFontColor)
                .font(decorator.topDateFont)
                .bold()

                Text(Date(timeIntervalSince1970: model.date),
                     style: decorator.secondaryDateStyle)
                .italic()
                .foregroundColor(decorator.secondaryDateFontColor)
                .font(decorator.secondaryDateFont)
            }
        }
    }
}
