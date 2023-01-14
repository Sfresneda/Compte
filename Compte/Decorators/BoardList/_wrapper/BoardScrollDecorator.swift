//
//  BoardScrollDecorator.swift
//  Compte
//
//  Created by likeadeveloper on 7/1/23.
//

import Foundation
import SwiftUI

protocol BoardScrollDecorator {
    var listRowInsets: EdgeInsets { get }

    var swipeDeleteActionLabel: Image { get }
    var swipeDeleteTint: Color { get }
    var swipeRenameActionLabel: Image { get }
    var swipeRenameTint: Color { get }

    var listRowBackground: Color { get }

    var backgroundColor: Color { get }
}

extension BoardScrollDecorator {
    var listRowInsets: EdgeInsets {
        EdgeInsets(top: .zero,
                   leading: .zero,
                   bottom: .zero,
                   trailing: 20)

    }
    var swipeDeleteActionLabel: Image {
        Image(systemName: "trash")
    }
    var swipeDeleteTint: Color {
        Color.warning
    }
    var swipeRenameActionLabel: Image {
        if #available(iOS 16, *) {
            return Image(systemName: "pencil.line")
        } else {
            return Image(systemName: "pencil")
        }
    }
    var swipeRenameTint: Color {
        Color.textSecondary
    }
    var listRowBackground: Color {
        Color.suplementaryBackground
    }
    var backgroundColor: Color {
        Color.grayBackground
    }
}
