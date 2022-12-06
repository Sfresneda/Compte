//
//  CompteApp.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

@main
struct CompteApp: App {
    var body: some Scene {
        WindowGroup {
            let vmodel = buildMainViewVM()
            MainView(vmodel: vmodel)
        }
    }
}

private extension CompteApp {
    func buildMainViewVM() -> MainVModel {
        MainVModel()
    }
}
