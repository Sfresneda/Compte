//
//  ViewBuilderCoordinator.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import SwiftUI
import CoreData

// MARK: - ViewBuilderCoordinator
struct ViewBuilderCoordinator {
    // MARK: Vars
    static var shared: ViewBuilderCoordinator = ViewBuilderCoordinator()

    // MARK: Lifecycle
    private init() {}
}

// MARK: - Public
extension ViewBuilderCoordinator {
    func buildListView() -> some View {
        let vmodel = BoardListVModel()
        return BoardListView(vmodel: vmodel)
    }
    func buildTapListView(object: CompteObject) -> some View {
        let vmodel = TapListVModel(modelObject: object)
        return TapListView<TapListVModel>(vmodel: vmodel)
    }
    func buildSettingsView() -> some View {
        let vmodel = SettingsVModel()
        return SettingsView(vmodel: vmodel)
    }
}
