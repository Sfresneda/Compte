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
        ZStack {
            VStack {
                List {
                    Section {
                        tapListPreview()
                        Toggle("Focus Mode",
                               isOn: $vmodel.focusMode)
                        
                    } header: {
                        Text("Tap List Appearance")
                    }
                }
            }
            VStack {
                Spacer()
                Text(vmodel.appVersionNumberText)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .navigationBarTitleDisplayMode(.large)
    }
}
extension SettingsView {
    func tapListPreview() -> some View {
        let vmodel = TapListVModel(modelObject: .previewImplementation(name: "Settings"))
        return TapListView(vmodel: vmodel, isNavBarStyleBlock: true)
            .disabled(true)
            .frame(minHeight: 350)
            .padding(EdgeInsets(top: -10,
                                leading: -20,
                                bottom: -10,
                                trailing: -20))
    }
}
