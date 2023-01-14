//
//  BoardListDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import Foundation
import SwiftUI

protocol BoardListDecorator {
    var navigationBarTintColor: UIColor { get }
    var navigationBarLargeTitleAttributes: [NSAttributedString.Key: Any] { get }
    var navigationBarTitleAttributes: [NSAttributedString.Key: Any] { get }

    var viewBackgroundColor: Color { get }

    var navigationBarTitleDisplayMode: NavigationBarItem.TitleDisplayMode { get }
    var navigationBarTitle: String { get }
    var navigationBarAccentColor: Color { get }

    var tapViewTextTitle: String { get }
    var tapViewFont: Font { get }
    var tapViewBackgroundColor: Color { get }
    var tapViewShadowRadius: CGFloat { get }
    var tapViewPadding: EdgeInsets { get }
}
extension BoardListDecorator {
    var navigationBarTintColor: UIColor {
        UIColor(named: "fireOrange")!
    }
    var navigationBarLargeTitleAttributes: [NSAttributedString.Key: Any] {
        [.foregroundColor: UIColor(named: "textPrimary")!]
    }
    var navigationBarTitleAttributes: [NSAttributedString.Key: Any] {
        [.foregroundColor: UIColor(named: "textPrimary")!]
    }
    var viewBackgroundColor: Color {
        Color.grayBackground
    }
    var navigationBarTitleDisplayMode: NavigationBarItem.TitleDisplayMode {
        .large
    }
    var navigationBarTitle: String {
        NSLocalizedString("boards_list_title", comment: "Compte boards")
    }
    var navigationBarAccentColor: Color {
        Color.textPrimary
    }
    var tapViewTextTitle: String {
        NSLocalizedString("add_new_board", comment: "new board")
    }
    var tapViewFont: Font {
        .system(size: 20)
    }
    var tapViewBackgroundColor: Color {
        .fireOrange
    }
    var tapViewShadowRadius: CGFloat {
        10
    }
    var tapViewPadding: EdgeInsets {
        EdgeInsets(top: .zero, leading: .zero, bottom: 20, trailing: .zero)
    }
}
