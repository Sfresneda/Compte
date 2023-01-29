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
            HStack(alignment: .center) {}
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ForEach(items.filter { $0.position == .left },
                            id: \.rawValue) { button in
                        itemToButton(button)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    ForEach(items.filter { $0.position == .right },
                            id: \.rawValue) { button in
                        itemToButton(button)
                    }
                }
            }
        }
    }
}
private extension NavbarButtonsView {
    func itemToButton(_ item: NavbarButton) -> some View {
        Button {
            action?(item)
        } label: {
            if let imageName = item.imageName {
                Image(systemName: imageName)
            } else {
                Text(item.name)
            }
        }
    }
}
