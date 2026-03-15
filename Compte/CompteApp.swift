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
    @Environment(\.scenePhase) var scenePhase

    init() {
        PhoneSyncService.shared.start()
    }

    var body: some Scene {
        WindowGroup {
            ViewBuilderCoordinator
                .shared
                .buildListView()
        }
        .onChange(of: scenePhase) { newValue in
            guard newValue == .background else { return }
            PersistenceManager.shared.save()
        }
    }
}
