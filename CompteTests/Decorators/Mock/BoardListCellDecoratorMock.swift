//
//  BoardListCellDecoratorMock.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import Foundation
import SwiftUI
@testable import Compte

struct BoardListCellDecoratorMock {}
extension BoardListCellDecoratorMock: BoardListCellDecorator {
    var boardTitleFont: Font {
        .callout
        .bold()
        .italic()
        .smallCaps()
        .monospacedDigit()
    }
    var boardForegroundColor: Color {
        .clear
        .opacity(0.5)
    }
    var boardTitleLinesLimit: Int {
        -1
    }
}
