//
//  CardCellBackgroundView.swift
//  Compte
//
//  Created by likeadeveloper on 16/1/23.
//

import Foundation
import SwiftUI

struct CardCellBackgroundView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack {
                Spacer()
                Text("")
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .background(Color.fireOrange)
            .frame(maxWidth: 90, maxHeight: .infinity)
            VStack {
                Spacer()
                Text("")
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .background(Color.suplementaryBackground)
            .frame(maxHeight: .infinity)
        }
        .frame(maxHeight: .infinity)
    }
}
