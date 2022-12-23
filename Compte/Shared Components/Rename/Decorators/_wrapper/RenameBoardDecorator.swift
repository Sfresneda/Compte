//
//  RenameBoardDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol RenameBoardDecorator {
    var limitChars: Int { get }
    var limitCharsText: String { get }
    var limitCharsMaxWidth: CGFloat { get }
    var limitCharsAligment: Alignment { get }
    var limitCharsSubmitButtonType: SubmitLabel { get }
    var limitCharsForegroundColor: Color { get }
    var limitCharsFont: Font { get }

    var viewCornerShadowRadius: CGFloat { get }
    var viewMaxHeight: CGFloat { get }
    var overlayColor: Color { get }
    var onAppearAnimation: Animation { get }
    var cancelButtonText: String { get }
    var cancelButtonTintColor: Color { get }
    var buttonsStyle: BorderedButtonStyle { get }
    var submitButtonText: String { get }
    var submitButtonTintColor: Color { get }

    func limitCharsLabelColor(_ isMaxCharactersReached: Bool) -> Color
    func limitCharsLabelFont(_ isMaxCharactersReached: Bool) -> Font
}

extension RenameBoardDecorator {
    var limitChars: Int {
        50
    }
    var limitCharsText: String {
        String(format: NSLocalizedString("limit_characters", comment: "limit characters"), limitChars)
    }
    var limitCharsMaxWidth: CGFloat {
        .infinity
    }
    var limitCharsAligment: Alignment {
        .leading
    }
    var limitCharsSubmitButtonType: SubmitLabel {
        .done
    }
    var limitCharsForegroundColor: Color {
        .primary
    }
    var limitCharsFont: Font {
        .title2
    }
    var viewCornerShadowRadius: CGFloat {
        20
    }
    var viewMaxHeight: CGFloat {
        300
    }
    var overlayColor: Color {
        .black.opacity(0.3)
    }
    var onAppearAnimation: Animation {
        .spring(dampingFraction: 0.75).delay(0.2)
    }
    var buttonsStyle: BorderedButtonStyle {
        .bordered
    }
    var cancelButtonText: String {
        NSLocalizedString("alert_cancel", comment: "Cancel button")
    }
    var cancelButtonTintColor: Color {
        .gray
    }
    var submitButtonText: String {
        NSLocalizedString("alert_submit", comment: "Submit button")
    }
    var submitButtonTintColor: Color {
        .blue
    }
    func limitCharsLabelColor(_ isMaxCharactersReached: Bool) -> Color {
        isMaxCharactersReached
        ? .red
        : .secondary
    }
    func limitCharsLabelFont(_ isMaxCharactersReached: Bool) -> Font {
        isMaxCharactersReached
        ? .title3
        : .footnote
    }
}
