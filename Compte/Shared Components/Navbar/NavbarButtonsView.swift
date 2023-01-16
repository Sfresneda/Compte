//
//  NavbarButtonsView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - NavbarButtonsView
struct NavbarButtonsView: View {
    // MARK: Vars
    @Binding var items: [NavbarButton]
    var action: ((NavbarButton) -> Void)?
    
    // MARK: Lifecycle
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
                    .buttonStyle(.automatic)
                }
            }
            .padding()
        }
    }
}
