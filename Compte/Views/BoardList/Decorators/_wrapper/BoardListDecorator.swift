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
    var navigationBarTitle: String { get }
    var tapViewTextTitle: String { get }
    var tapViewFont: Font { get }
    var tapViewBackgroundColor: Color { get }
    var tapViewShadowRadius: CGFloat { get }
    var tapViewPadding: EdgeInsets { get }
}
extension BoardListDecorator {
    var navigationBarTitleDisplayMode: NavigationBarItem.TitleDisplayMode {
        .large
    }
    var navigationBarTitle: String {
        NSLocalizedString("boards_list_title", comment: "Compte boards")
    }
    var tapViewTextTitle: String {
        NSLocalizedString("add_new_board", comment: "new board")
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
    var tapViewPadding: EdgeInsets {
        EdgeInsets(top: .zero, leading: .zero, bottom: 20, trailing: .zero)
    }
}
