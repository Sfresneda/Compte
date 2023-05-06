//
//  CounterView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - CounterView
struct CounterView: View {
    // MARK: Vars
    @Binding var currentValue: Int

    // MARK: Lifecycle
    var body: some View {
        ZStack {
            VisualEffectView(style: .regular)
            HStack(alignment: .center) {
                Text("\(currentValue)")
                    .font(.system(size: 50))
                    .bold()
            }
            .foregroundColor(Color.textPrimary)
        }
        .background(Color.suplementaryBackground)
    }
}
