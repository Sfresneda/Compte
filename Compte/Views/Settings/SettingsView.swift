//
//  SettingsView.swift
//  Compte
//
//  Created by likeadeveloper on 6/5/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vmodel: SettingsVModel

    var body: some View {
            List {
                SettingsListContent(focusMode: vmodel.focusMode,
                                    sections: vmodel.sections)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Settings")
            Spacer()
            Text(vmodel.appVersionNumberText)
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(maxHeight: 5)

    }
}
