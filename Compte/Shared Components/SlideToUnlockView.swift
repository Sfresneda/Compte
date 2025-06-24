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
               step: 5)
        {}.onChange(of: sliderValue) { newValue in
            if newValue >= maxValue {
                action?()
                withAnimation {
                    sliderValue = .zero
                }
            }
        }.accessibilityLabel(
            Text(
                NSLocalizedString(
                    "reset_counter",
                    comment: "Reset Counter"
                )
            )
        )
        .tint(Color.suplementaryBackground)
        .foregroundColor(.red)
    }
}

#Preview {
    SlideToUnlockView(action: nil)
        .padding()
}

