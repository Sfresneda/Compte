//
//  RenameBoardDecoratorMock.swift
//  CompteTests
//
//  Created by likeadeveloper on 14/1/23.
//

import Foundation
import SwiftUI
@testable import Compte

struct RenameBoardDecoratorMock {}
extension RenameBoardDecoratorMock: RenameBoardDecorator {
    var viewBackgroundColor: Color {
        .clear
        .opacity(0.5)
    }
    var textEditorBackgroundColor: Color {
        .clear
        .opacity(0.5)
    }
    var textEditorCornerRadius: CGFloat {
        .pi
    }
    var viewCornerShadowRadius: CGFloat {
        .pi
    }
    var viewMaxHeight: CGFloat {
        .pi
    }
    var overlayColor: Color {
        .clear
        .opacity(0.5)
    }
    var onAppearAnimation: Animation {
        .linear.delay(.pi)
    }
    var cancelButtonText: String {
        String(describing: self)
    }
    var cancelButtonTintColor: Color {
        .clear
        .opacity(0.5)
    }
    var buttonsStyle: BorderedButtonStyle {
        .init()
    }
    var submitButtonText: String {
        String(describing: self)
    }
    var submitButtonTintColor: Color {
        .clear
        .opacity(0.5)
    }
}
