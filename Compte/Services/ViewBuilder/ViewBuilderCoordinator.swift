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
        return ItemsListView(vmodel: vmodel)
    }
    
    func buildTapListView(object: CompteObject) -> some View {
        let vmodel = TapListVModel(modelObject: object)
        return TapListView<TapListVModel>(vmodel: vmodel)
    }
}
