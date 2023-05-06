//
//  UserDefaultsSpy.swift
//  CompteTests
//
//  Created by likeadeveloper on 6/5/23.
//

import Foundation
@testable import Compte

final class UserDefaultsSpy {
    var purgueSpy: Bool = false
    var toogleFocusModeSpy: Bool = false
    var getFocusModeSpy: Bool = false
}
extension UserDefaultsSpy: UserDefaultsManagerProtocol {
    static var shared: Compte.UserDefaultsManagerProtocol {
        UserDefaultsSpy()
    }

    func purgue() {
        purgueSpy.toggle()
    }

    func toogleFocusMode() {
        toogleFocusModeSpy.toggle()
    }

    func getFocusMode() -> Bool {
        getFocusModeSpy.toggle()
        return false
    }
}
