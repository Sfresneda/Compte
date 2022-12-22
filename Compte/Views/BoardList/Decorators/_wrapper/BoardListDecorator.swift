//
//  BoardListDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol BoardListDecorator {
    var navigationBarTitleDisplayMode: NavigationBarItem.TitleDisplayMode { get }
    var tapViewTextTitle: String { get }
    var tapViewFont: Font { get }
    var tapViewBackgroundColor: Color { get }
    var tapViewShadowRadius: CGFloat { get }
}
extension BoardListDecorator {
    var navigationBarTitleDisplayMode: NavigationBarItem.TitleDisplayMode {
        .inline
    }
    var tapViewTextTitle: String {
        "Add New Compte"
    }
    var tapViewFont: Font {
        .system(size: 20)
    }
    var tapViewBackgroundColor: Color {
        .blue
    }
    var tapViewShadowRadius: CGFloat {
        10
    }
}
