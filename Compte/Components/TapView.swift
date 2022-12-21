//
//  TapView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - TapView
struct TapView<ButtonRepresentation: View>: View {
    // MARK: Vars
    var icon: () -> ButtonRepresentation
    var buttonFont: () -> Font?
    var maxWidth: () -> CGFloat?
    var action: (() -> Void)?
    
    init(@ViewBuilder representation: @escaping (() -> ButtonRepresentation) = { Image(systemName: "plus") },
         buttonFont: @escaping () -> Font? = { nil },
         maxWidth: @escaping () -> CGFloat? = { nil },
         action: (() -> Void)? = nil) {
        self.icon = representation
        self.action = action
        self.buttonFont = buttonFont
        self.maxWidth = maxWidth
    }
    
    // MARK: Lifecycle
    var body: some View {
        Button() {
            action?()
        } label: {
            icon()
                .padding()
                .frame(maxWidth: maxWidth())
        }
        .foregroundColor(.white)
        .font(buttonFont())
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
            TapView(representation: {
                Text("Add New Compte")
            }, buttonFont: { .system(size: 50) })
            .background(.blue)
            .clipShape(Capsule())
            .shadow(radius: 10)
            .padding()
        }
    }
}
struct MAXWIDTHTapView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image(systemName: "person.2.wave.2")
                .resizable()
                .scaledToFill()
            TapView(buttonFont: {
                .system(size: 50)
            }, maxWidth: { .infinity })
            .background(.blue)
            .clipShape(Capsule())
            .shadow(radius: 10)
            .padding()
        }
    }
}

