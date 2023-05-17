//
//  SettingsAppearanceView.swift
//  Compte
//
//  Created by likeadeveloper on 17/5/23.
//

import SwiftUI

struct SettingsAppearanceView: View {
    @State var isFocusModeEnabled: Bool

    var body: some View {
        tapListPreview()
        Toggle("Focus Mode",
               isOn: $isFocusModeEnabled)
    }
}


extension SettingsAppearanceView {
    func tapListPreview() -> some View {
        let vmodel = TapListVModel(modelObject: .previewImplementation)
        return TapListView(vmodel: vmodel, isNavBarStyleBlock: true)
            .disabled(true)
            .frame(minHeight: 350)
            .padding(EdgeInsets(top: -10,
                                leading: -20,
                                bottom: -10,
                                trailing: -20))
    }
}
