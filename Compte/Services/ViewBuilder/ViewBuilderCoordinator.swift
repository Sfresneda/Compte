//
//  ViewBuilderCoordinator.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import SwiftUI
import CoreData

struct ViewBuilderCoordinator {
    static var shared: ViewBuilderCoordinator = ViewBuilderCoordinator()
}

extension ViewBuilderCoordinator {
    func createMock() {
    }
    @MainActor
    func buildListView() -> some View {
        let vmodel = ItemsListVModel()
        return ItemsListView(model: vmodel)
    }
    
    func buildMainView(compteModel: CompteObject) -> some View {
        let vmodel = MainVModel()
        return MainView(vmodel: vmodel)
    }
}
