//
//  SettingsVModel.swift
//  Compte
//
//  Created by likeadeveloper on 6/5/23.
//

import Foundation
import Combine

// MARK: - SettingsVModel
final class SettingsVModel: ObservableObject {
    // MARK: Vars
    private var persistenceManager: UserDefaultsManagerProtocol
    @Published var focusMode: Bool = false

    // MARK: Lifecycle
    init(persistenceManager: UserDefaultsManagerProtocol = UserDefaultsManager.shared) {
        self.persistenceManager = persistenceManager
        observeAndUpdatePersistenceValues()
    }
}
// MARK: - Public
extension SettingsVModel {
    var appVersionNumberText: String {
        let bundle = Bundle.main
        let releaseVersion = bundle.releaseVersionNumber
        let buildVersion = bundle.buildVersionNumber
        return "V\(releaseVersion ?? "-")(\(buildVersion ?? "-"))"
    }
    func setFocusMode() {
        persistenceManager.toogleFocusMode()
        observeAndUpdatePersistenceValues()
    }
}
// MARK: - Private
private extension SettingsVModel {
    func observeAndUpdatePersistenceValues() {
        focusMode = persistenceManager.getFocusMode()
    }
}
