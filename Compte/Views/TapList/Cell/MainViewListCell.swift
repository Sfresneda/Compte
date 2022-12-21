//
//  MainViewListCell.swift
//  Compte
//
//  Created by likeadeveloper on 8/12/22.
//

import SwiftUI

// MARK: - MainViewListCell
struct MainViewListCell: View {
    // MARK: Vars
    var model: TapObject

    // MARK: Lifecycle
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                Text("\(model.tapNumber)")
                    .font(.system(size: 50))
                    .bold()
                    .minimumScaleFactor(0.1)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: .zero))
            }
            .aspectRatio(1, contentMode: .fit)
            VStack(alignment: .leading) {
                Text(Date(timeIntervalSince1970: model.date),
                     format: Date.FormatStyle().hour().minute().second())
                .font(.title2)
                .bold()
                Text(Date(timeIntervalSince1970: model.date),
                     style: .date)
                .font(.title3)
            }
        }
    }
}

// MARK: - Preview
struct MainViewListCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = TapObject(date: Date().timeIntervalSince1970,
                             tapNumber: 1)
        MainViewListCell(model: model)
    }
}
