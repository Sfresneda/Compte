//
//  MainViewListCell.swift
//  Compte
//
//  Created by likeadeveloper on 8/12/22.
//

import SwiftUI

struct MainViewListCell: View {
    var model: TapModel
    var body: some View {
        HStack(alignment: .center) {
            ZStack {
                Text("\(model.tapNumber)")
                    .font(.system(size: 30))
                    .minimumScaleFactor(0.1)
                    .fontDesign(.rounded)
                    .padding()
            }
            .aspectRatio(1, contentMode: .fit)
            VStack(alignment: .listRowSeparatorLeading) {
                Text(Date(timeIntervalSince1970: model.date),
                     format: Date.FormatStyle().hour().minute().second())
                .fontDesign(.monospaced)
                .font(.title2)
                Text(Date(timeIntervalSince1970: model.date),
                     style: .date)
                .fontDesign(.serif)
                .font(.title3)
                
            }
        }
    }
}
struct MainViewListCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = TapModel(date: Date().timeIntervalSince1970,
                             tapNumber: 1)
        MainViewListCell(model: model)
    }
}
