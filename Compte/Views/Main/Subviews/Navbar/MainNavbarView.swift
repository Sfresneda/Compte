//
//  MainNavbarView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - Lifecycle
struct MainNavbarView: View {
    // MARK: Vars
    private var action: ((MainNavbarButton) -> Void)?
    
    // MARK: Body
    var body: some View {
        HStack(alignment: .center) {
            ForEach(MainNavbarButton.allCases, id: \.rawValue) { button in
                Button {
                    action?(button)
                } label: {
                    Image(systemName: button.imageName)
                }
                .buttonStyle(.borderedProminent)
                .frame(maxHeight: .infinity,
                       alignment: .center)
            }
        }
        .padding()
    }
}

// MARK: - Public
extension MainNavbarView {
    func onTapSomeButton(perform action: @escaping (MainNavbarButton) -> Void) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

// MARK: - Preview
struct MainNavbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavbarView()
    }
}
