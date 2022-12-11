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
    var action: (() -> Void)?
    
    // MARK: Body
    var body: some View {
        VStack {
            Button() {
                action?()
            } label: {
                Image(systemName: "plus")
                    .frame(maxWidth: .infinity,
                           maxHeight: 120)
            }
            .background(.blue)
            .foregroundColor(.white)
            .font(.system(size: 50))
        }
        .onTapGesture { action?() }
    }
}

// MARK: - Preview
struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image(systemName: "person.2.wave.2")
                .resizable()
                .scaledToFill()
            TapView()
        }
    }
}
