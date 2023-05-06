//
//  UserDefaultsManager.swift
//  Compte
//
//  Created by likeadeveloper on 6/5/23.
//

import Foundation

// MARK: - UserDefaultsManager
final class UserDefaultsManager {
    // MARK: Vars
    static var shared: UserDefaultsManagerProtocol = UserDefaultsManager()

    private enum Constants: String, CaseIterable {
        case focusMode
    }

    // MARK: Lifecycle
    private init() { }
}

// MARK: - UserDefaultsManagerProtocol
extension UserDefaultsManager: UserDefaultsManagerProtocol {}

// MARK: - Public
extension UserDefaultsManager {
    // MARK: Helpers
    func purgue() {
        Constants
            .allCases
            .forEach {
                UserDefaults
                    .standard
                    .removeObject(forKey: $0.rawValue)
            }
    }

    // MARK: Focus Mode
    func toogleFocusMode() {
        UserDefaults
            .standard
            .set(!getFocusMode(),
                 forKey: Constants.focusMode.rawValue)
    }
    func getFocusMode() -> Bool {
        UserDefaults
            .standard
            .bool(forKey: Constants.focusMode.rawValue)
    }
}
