//
//  MainNavbarWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation

enum MainNavbarButton: Int, CaseIterable {
    case editName
    case new
    
    var name: String {
        switch self {
        case .editName:
            return "Edit Name"
        case .new:
            return "New Counter"
        }
    }
    
    var imageName: String {
        switch self {
        case .editName:
            return "pencil"
        case .new:
            return "plus.circle"
        }
    }
}
