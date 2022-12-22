//
//  BoardListCellDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol BoardListCellDecorator {
    var tapsIndicatorFont: Font { get }
    var tapsIndicatorForegroundColor: Color { get }
    var tapsIndicatorPadding: EdgeInsets { get }
    var tapsIndicatorBackgroundColor: Color { get }
    var tapsIndicatorCornerRadious: CGFloat { get }

    var boardTitleFont: Font { get }
    var boardForegroundColor: Color { get }

    var lastModificationFormat: Date.FormatStyle { get }
    var lastModificationFont: Font { get }
    var lastModificationForegroundColor: Color { get }

    var swipeActionDeleteImageName: String { get }
    var swipeActionRenameImageName: String { get }
    var swipeActionRenameColor: Color { get }
}
extension BoardListCellDecorator {
    var tapsIndicatorFont: Font {
        .largeTitle
    }
    var tapsIndicatorForegroundColor: Color {
        .white
    }
    var tapsIndicatorPadding: EdgeInsets {
        EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8)
    }
    var tapsIndicatorBackgroundColor: Color {
        .secondary
    }
    var tapsIndicatorCornerRadious: CGFloat {
        20
    }
    var boardTitleFont: Font {
        .title2
    }
    var boardForegroundColor: Color {
        .primary
    }
    var lastModificationFormat: Date.FormatStyle {
        Date.FormatStyle().year().month().day().locale(Locale.current)
    }
    var lastModificationFont: Font {
        .subheadline
    }
    var lastModificationForegroundColor: Color {
        .secondary
    }
    var swipeActionDeleteImageName: String {
        "trash"
    }
    var swipeActionRenameImageName: String {
        "pencil.line"
    }
    var swipeActionRenameColor: Color {
        .blue
    }
}
