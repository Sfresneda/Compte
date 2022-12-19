//
//  MainNavbarWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import Foundation

enum MainNavbarButton: Int, CaseIterable {
    case new
    
    var name: String {
        switch self {
        case .new:
            return "New Item"
        }
    }
    
    var imageName: String {
        switch self {
        case .new:
            return "plus.circle"
        }
    }
}
