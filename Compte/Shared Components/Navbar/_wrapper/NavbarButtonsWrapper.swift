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
    case delete

    // MARK: Vars
    var name: String {
        switch self {
        case .new:
            return NSLocalizedString("new_item", comment: "New Item Button")
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
        }
    }
}
