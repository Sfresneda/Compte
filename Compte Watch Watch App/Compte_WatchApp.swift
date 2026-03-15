//
//  Compte_WatchApp.swift
//  Compte Watch Watch App
//
//  Created by sergio fresneda on 3/15/26.
//

import SwiftUI

@main
struct Compte_Watch_Watch_AppApp: App {

    @StateObject private var syncStore = WatchSyncStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(syncStore)
                .onAppear {
                    syncStore.start()
                }
        }
    }
}
