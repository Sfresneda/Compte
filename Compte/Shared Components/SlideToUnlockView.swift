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
    var action: (() -> Void)?
    
    // MARK: Lifecycle
    var body: some View {
        Slider(value: $sliderValue,
               in: .zero...100,
               step: 5) {
            Text(NSLocalizedString("reset_counter",
                                   comment: "Reset Counter"))
        } onEditingChanged: { editing in
            handleSliderChangeValue(isEditing: editing)
        }
        .tint(Color.suplementaryBackground)
        .foregroundColor(.red)
    }
}
// MARK: - Helper
private extension SlideToUnlockView {
    func handleSliderChangeValue(isEditing: Bool) {
        guard !isEditing else { return }
        guard sliderValue == 100 else {
            resetSlider()
            return
        }
        action?()
        resetSlider()
    }
    func resetSlider() {
        sliderValue = .zero
    }
}
