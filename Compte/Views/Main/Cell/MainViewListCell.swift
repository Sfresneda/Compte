//
//  MainViewListCell.swift
//  Compte
//
//  Created by likeadeveloper on 8/12/22.
//

import SwiftUI

struct MainViewListCell: View {
    var model: TapObject
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
            VStack(alignment: .listRowSeparatorLeading) {
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
struct MainViewListCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = TapObject(date: Date().timeIntervalSince1970,
                             tapNumber: 1)
        MainViewListCell(model: model)
    }
}
