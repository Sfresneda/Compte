//
//  RenameCardView.swift
//  Compte
//
//  Created by likeadeveloper on 19/12/22.
//

import SwiftUI

// MARK: - RenameBoardView
struct RenameCardView: View {
    // MARK: Vars
    @State var model: String = ""
    @State private(set) var isPresented: Bool = false
    var onCancel: (() -> Void)?
    var onSubmit: ((String) -> Void)?
    @FocusState private(set) var isTextFieldFocused: Bool
    @State private(set) var isMaxCharactersReached: Bool = false
    let decorator: RenameBoardDecorator = DefaultRenameBoardDecorator()

    // MARK: Lifecycle
    var body: some View {
        VStack {
            cardView()
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .center)
        .background(decorator.overlayColor)
        .onAppear {
            withAnimation(decorator.onAppearAnimation) {
                isPresented.toggle()
                isTextFieldFocused.toggle()
            }
        }
        .onTapGesture {
            onCancel?()
        }
    }
}
extension RenameCardView {
    func setMaxCharactersReached(_ newValue: Bool) {
        isMaxCharactersReached = newValue
    }
}

// MARK: - Preview
struct RenameCardView_Previews: PreviewProvider {
    static var previews: some View {
        let model = "Compte for testing purposes, Compte for testing"
        ZStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .background(.mint)

            RenameCardView(model: model)
        }
    }
}

struct EmptyRenameCardView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ""
        ZStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .background(.mint)

            RenameCardView(model: model)
        }
    }
}
