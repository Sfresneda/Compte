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
    var tapsIndicatorTextAligment: TextAlignment { get }
    var tapsIndicatorMaxWidth: CGFloat { get }
    var tapsIndicatorMaxHeight: CGFloat { get }
    var tapsIndicatorAligment: Alignment { get }
    var tapsIndicatorPadding: EdgeInsets { get }
    var tapsIndicatorBackgroundColor: Color { get }
    var tapsIndicatorCornerRadious: CGFloat { get }

    var boardTitleFont: Font { get }
    var boardForegroundColor: Color { get }
    var boardTitleLinesLimit: Int { get }

    var lastModificationFormat: Date.FormatStyle { get }
    var lastModificationFont: Font { get }
    var lastModificationForegroundColor: Color { get }
}
extension BoardListCellDecorator {
    var tapsIndicatorFont: Font {
        .largeTitle
    }
    var tapsIndicatorForegroundColor: Color {
        .white
    }
    var tapsIndicatorTextAligment: TextAlignment {
        .center
    }
    var tapsIndicatorMaxWidth: CGFloat {
        100
    }
    var tapsIndicatorMaxHeight: CGFloat {
        .infinity
    }
    var tapsIndicatorAligment: Alignment {
        .center
    }
    var tapsIndicatorPadding: EdgeInsets {
        EdgeInsets()
    }
    var tapsIndicatorBackgroundColor: Color {
        .fireOrange
    }
    var tapsIndicatorCornerRadious: CGFloat {
        .zero
    }
    var boardTitleFont: Font {
        .title2
    }
    var boardForegroundColor: Color {
        .textPrimary
    }
    var boardTitleLinesLimit: Int {
        1
    }
    var lastModificationFormat: Date.FormatStyle {
        Date.FormatStyle().year().month().day().locale(Locale.current)
    }
    var lastModificationFont: Font {
        .subheadline
    }
    var lastModificationForegroundColor: Color {
        .textSecondary
    }
}
