//
//  RenameBoardDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol RenameBoardDecorator {
    var viewBackgroundColor: Color { get }
    var limitChars: Int { get }
    var limitCharsText: String { get }
    var limitCharsMaxWidth: CGFloat { get }
    var limitCharsAligment: Alignment { get }
    var limitCharsSubmitButtonType: SubmitLabel { get }
    var limitCharsForegroundColor: Color { get }
    var limitCharsFont: Font { get }
    var textEditorBackgroundColor: Color { get }
    var textEditorCornerRadius: CGFloat { get }
    
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
    var viewBackgroundColor: Color {
        Color.grayBackground
    }
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
        .textPrimary
    }
    var limitCharsFont: Font {
        .title2
    }
    var textEditorBackgroundColor: Color {
        .red
    }
    var textEditorCornerRadius: CGFloat {
        8
    }
    var viewCornerShadowRadius: CGFloat {
        20
    }
    var viewMaxHeight: CGFloat {
        300
    }
    var overlayColor: Color {
        Color.smokeBlueBackground.opacity(0.9)
    }
    var onAppearAnimation: Animation {
        .spring(dampingFraction: 0.75).delay(0.1)
    }
    var buttonsStyle: BorderedButtonStyle {
        .bordered
    }
    var cancelButtonText: String {
        NSLocalizedString("alert_cancel", comment: "Cancel button")
    }
    var cancelButtonTintColor: Color {
        Color.textPrimary
    }
    var submitButtonText: String {
        NSLocalizedString("alert_submit", comment: "Submit button")
    }
    var submitButtonTintColor: Color {
        Color.fireOrange
    }
    func limitCharsLabelColor(_ isMaxCharactersReached: Bool) -> Color {
        isMaxCharactersReached
        ? Color.warning
        : Color.textSecondary
    }
    func limitCharsLabelFont(_ isMaxCharactersReached: Bool) -> Font {
        isMaxCharactersReached
        ? .title3
        : .footnote
    }
}
