//
//  CompteApp.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI
import CoreData

@main
struct CompteApp: App {
    var body: some Scene {
        WindowGroup {
            ViewBuilderCoordinator
                .shared
                .buildListView()
        }
    }
}
