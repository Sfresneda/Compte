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
        VStack {
            List {
                Section {
                    Toggle("Focus Mode",
                           isOn: $vmodel.focusMode)
                    tapListPreview()
                        .disabled(true)
                        .frame(minHeight: 350)
                } footer: {
                    Text("Explanation about what means this feature")
                }
            }
            Spacer()
            Text(vmodel.appVersionNumberText)
        }
    }
}
extension SettingsView {
    func tapListPreview() -> some View {
        let vmodel = TapListVModel(modelObject: .previewImplementation())
        return TapListView(vmodel: vmodel)
    }
}
