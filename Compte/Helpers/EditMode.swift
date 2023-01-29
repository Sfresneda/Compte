//
//  EditMode.swift
//  Compte
//
//  Created by likeadeveloper on 31/12/22.
//

import Foundation
import SwiftUI

// MARK: - Bool & EditMode
extension Bool {
    var toEditMode: EditMode {
        get {
            self
            ? .active
            : .inactive
        }
        set {
            self = newValue == .active
        }
    }
}
