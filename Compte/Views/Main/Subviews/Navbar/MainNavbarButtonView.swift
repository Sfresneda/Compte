//
//  MainNavbarButtonView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - Lifecycle
struct MainNavbarButtonsView: View {
    // MARK: Vars
    var items: [MainNavbarButton] = MainNavbarButton.allCases
    var action: ((MainNavbarButton) -> Void)?
    
    // MARK: Body
    var body: some View {
        HStack(alignment: .center) {
            ForEach(items, id: \.rawValue) { button in
                Button {
                    action?(button)
                } label: {
                    Image(systemName: button.imageName)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct MainNavbarButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavbarButtonsView(action: { button in
            debugPrint(button)
        })
    }
}
