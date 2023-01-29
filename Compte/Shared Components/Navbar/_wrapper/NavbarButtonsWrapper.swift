//
//  NavbarButtonsWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation

// MARK: - NavbarButton
enum NavbarButton: Int, CaseIterable {
    case new
    case edit
    case done
    case delete
}
enum NavBarPosition {
    case right
    case left
}

extension NavbarButton {
    var name: String {
        switch self {
        case .new:
            return NSLocalizedString("new_item", comment: "New Item Button")
        case .edit:
            return NSLocalizedString("edit_item", comment: "Edit button")
        case .done:
            return NSLocalizedString("done_item", comment: "Done button")
        case .delete:
            return NSLocalizedString("delete_item", comment: "Delete Item Button")
        }
    }
    var imageName: String? {
        switch self {
        case .new:
            return "square.and.pencil"
        case .delete:
            return "trash"
        default:
            return nil
        }
    }
    var position: NavBarPosition {
        switch self {
        case .edit,
                .delete,
                .new:
            return .right
        case .done:
            return .left
        }
    }
}
