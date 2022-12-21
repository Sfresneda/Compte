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
    static var shared: ViewBuilderCoordinator = ViewBuilderCoordinator()
}

// MARK: - Public
extension ViewBuilderCoordinator {
    @MainActor
    func buildListView() -> some View {
        let vmodel = BoardListVModel()
        return BoardListView(vmodel: vmodel)
    }
    
    @MainActor
    func buildTapListView(object: CompteObject) -> some View {
        let vmodel = TapListVModel(modelObject: object)
        return TapListView<TapListVModel>(vmodel: vmodel)
    }
}
