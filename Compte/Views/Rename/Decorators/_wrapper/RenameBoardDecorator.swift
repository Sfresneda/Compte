//
//  RenameBoardDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol RenameBoardDecorator {
    var limitCharacters: Int { get }
    var limitCharactersText: String { get }
    var limitCharactersMaxWidth: CGFloat { get }
    var limitCharactersAligment: Alignment { get }
    var viewCornerShadowRadius: CGFloat { get }
    var viewMaxHeight: CGFloat { get }
    var overlayColor: Color { get }
    var onAppearAnimation: Animation { get }
    var cancelButtonText: String { get }
    var submitButtonText: String { get }

    func limitCharactersLabelColor(_ isMaxCharactersReached: Bool) -> Color
    func limitCharactersLabelFont(_ isMaxCharactersReached: Bool) -> Font
}

extension RenameBoardDecorator {
    var limitCharacters: Int {
        50
    }
    var limitCharactersText: String {
        String(format: NSLocalizedString("limit_characters", comment: "limit characters"), limitCharacters)
    }
    var limitCharactersMaxWidth: CGFloat {
        .infinity
    }
    var limitCharactersAligment: Alignment {
        .leading
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
    var cancelButtonText: String {
        NSLocalizedString("alert_cancel", comment: "Cancel button")
    }
    var submitButtonText: String {
        NSLocalizedString("alert_submit", comment: "Submit button")
    }
    func limitCharactersLabelColor(_ isMaxCharactersReached: Bool) -> Color {
        isMaxCharactersReached
        ? .secondary
        : .red
    }
    func limitCharactersLabelFont(_ isMaxCharactersReached: Bool) -> Font {
        isMaxCharactersReached
        ? .footnote
        : .title3
    }
}
