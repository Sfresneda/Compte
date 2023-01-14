//
//  TapListDecoratorMock.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import Foundation
import SwiftUI
@testable import Compte

struct TapListDecoratorMock {}
extension TapListDecoratorMock: TapListDecorator {
    var slideToUnlockAnimation: Animation {
        .linear.delay(.pi)
    }
    var slideToUnlockImageName: String {
        String(describing: self)
    }
    var slideToUnlockImageFont: Font {
        .callout
        .bold()
        .italic()
        .monospacedDigit()
        .smallCaps()
    }
    var slideToUnlockPadding: EdgeInsets {
        .init(.zero)
    }
}
