//
//  TapView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - Lifecycle
struct TapView: View {
    // MARK: Vars
    private var action: (()->Void)?
    
    // MARK: Body
    var body: some View {
        Group {
            Button("Tap") {
                action?()
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
        }
        .background(Color.mint)
        .frame(maxHeight: 40)
        .padding(EdgeInsets(top: 5,
                            leading: 20,
                            bottom: 5,
                            trailing: 20))
    }
}

// MARK: - Builder
extension TapView {
    func actionOnComplete(perform action: @escaping () -> Void) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

// MARK: - Preview
struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView().actionOnComplete {
            debugPrint("tap")
        }
    }
}
