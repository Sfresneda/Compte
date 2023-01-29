//
//  TapListCellDecoratorMock.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import Foundation
import SwiftUI
@testable import Compte

struct TapListCellDecoratorMock {}
extension TapListCellDecoratorMock: TapListCellDecorator {
    var secondaryDateStyle: Text.DateStyle {
        .time
    }
    var secondaryDateFont: Font {
        .callout
        .bold()
        .monospacedDigit()
        .italic()
        .smallCaps()
    }
    var secondaryDateFontColor: Color {
        .clear
        .opacity(0.5)
    }
}
