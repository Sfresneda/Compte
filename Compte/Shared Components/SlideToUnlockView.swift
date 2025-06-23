//
//  SlideToUnlockView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - SlideToUnlockView
struct SlideToUnlockView: View {
    // MARK: Vars
    @State private var sliderValue: Float = .zero
    private let maxValue: Float = 100
    var action: (() -> Void)?
    
    // MARK: Lifecycle
    var body: some View {
        Slider(value: $sliderValue,
               in: .zero...maxValue,
               step: 5) {
            Text(NSLocalizedString("reset_counter",
                                   comment: "Reset Counter"))
        } onEditingChanged: { editing in
            guard !editing else { return }
            let value = sliderValue

            withAnimation {
                sliderValue = .zero
            }

            if value >= maxValue {
                action?()
            }
        }
        .tint(Color.suplementaryBackground)
        .foregroundColor(.red)
    }
}
