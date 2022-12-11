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

    private var container: NSPersistentContainer
    private var manager: CompteManager

    private init() {
        container = NSPersistentContainer(name: "CompteModel")
        manager = CompteManager(container: container)
    }
}

extension ViewBuilderCoordinator {
    func createMock() {
        let entity = CompteEntity(context: manager.context)
        entity.id = UUID()
        manager.add(entity, requireSave: true)
    }
    func buildListView() -> some View {
        let vmodel = ItemsListVModel(dataManager: manager)
        return ItemsListView(model: vmodel)
    }

    func buildMainView() -> some View {
        let vmodel = MainVModel()
        return MainView(vmodel: vmodel)
    }
}
