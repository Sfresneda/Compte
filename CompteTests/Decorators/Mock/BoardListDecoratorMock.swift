//
//  BoardListDecoratorMock.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import Foundation
import SwiftUI
@testable import Compte

struct BoardListDecoratorMock {}
extension BoardListDecoratorMock: BoardListDecorator {
    var tapViewTextTitle: String {
        "test_mock"
    }
    var tapViewFont: Font {
        .callout
        .bold()
        .italic()
        .monospacedDigit()
        .smallCaps()
    }
    var tapViewBackgroundColor: Color {
        .clear.opacity(0.5)
    }
    var tapViewShadowRadius: CGFloat {
        3.141592653589793238464338327950288
    }
    var tapViewPadding: EdgeInsets {
        .init(.zero)
    }
}
