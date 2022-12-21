//
//  NavbarButtonsView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - Lifecycle
struct NavbarButtonsView: View {
    // MARK: Vars
    @Binding var items: [NavbarButton]
    var action: ((NavbarButton) -> Void)?
    
    // MARK: Body
    var body: some View {
        if !items.isEmpty {
            HStack(alignment: .center) {
                ForEach(items, id: \.rawValue) { button in
                    Button {
                        action?(button)
                    } label: {
                        if let imageName = button.imageName {
                            Image(systemName: imageName)
                        } else {
                            Text(button.name)
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview
struct MainNavbarButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarButtonsView(items: .constant(NavbarButton.allCases),
                          action: { _ in /* Silent is golden */ })
    }
}
