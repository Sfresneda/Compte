//
//  SlideToUnlockView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI
// MARK: - Lifecycle
struct SlideToUnlockView: View {
    // MARK: Vars
    @State private var sliderValue: Float = .zero
    private var action: (() -> Void)?
    
    // MARK: Body
    var body: some View {
        Slider(value: $sliderValue,
               in: 0...100,
               step: 5) {
            Text("Reset counter")
        } onEditingChanged: { editing in
            handleSliderChangeValue(isEditing: editing)
        }
    }
}

// MARK: - Public
extension SlideToUnlockView {
    func actionOnComplete(perform action: @escaping () -> Void) -> Self {
        var copy = self
        copy.action = action
        return copy
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

// MARK: - Preview
struct SlideToUnlockView_Previews: PreviewProvider {
    static var previews: some View {
        SlideToUnlockView()
    }
}
