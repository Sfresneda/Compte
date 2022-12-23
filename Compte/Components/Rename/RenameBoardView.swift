//
//  RenameBoardView.swift
//  Compte
//
//  Created by likeadeveloper on 19/12/22.
//

import SwiftUI

// MARK: - RenameBoardView
struct RenameBoardView: View {
    // MARK: Vars
    @State var model: String
    @State private var isPresented: Bool = false
    var onCancel: (() -> Void)?
    var onSubmit: ((String) -> Void)?
    @FocusState private var isTextFieldFocused: Bool
    @State private var isMaxCharactersReached: Bool = false
    let decorator: RenameBoardDecorator = DefaultRenameBoardDecorator()

    // MARK: Lifecycle
    var body: some View {
        VStack {
            if isPresented {
                VStack(alignment: .center) {
                    Text(decorator.limitCharsText)
                        .font(decorator.limitCharsLabelFont(isMaxCharactersReached))
                        .foregroundColor(decorator.limitCharsLabelColor(isMaxCharactersReached))
                        .frame(maxWidth: decorator.limitCharsMaxWidth,
                               alignment: decorator.limitCharsAligment)

                    TextEditor(text: $model)
                        .limitCharacters($model,
                                         limit: decorator.limitChars,
                                         limitReached: { isReached in
                            withAnimation {
                                isMaxCharactersReached = isReached
                            }
                        })
                        .focused($isTextFieldFocused)
                        .submitLabel(decorator.limitCharsSubmitButtonType)
                        .foregroundColor(decorator.limitCharsForegroundColor)
                        .font(decorator.limitCharsFont)

                    HStack(alignment: .center) {
                        Button {
                            onCancel?()
                        } label: {
                            Text(decorator.cancelButtonText)
                        }
                        .tint(.gray)
                        .buttonStyle(.bordered)

                        Button {
                            onSubmit?(model)
                        } label: {
                            Text(decorator.submitButtonText)
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                        .disabled(isMaxCharactersReached)
                    }
                }
                .padding()
                .background(.background)
                .cornerRadius(decorator.viewCornerShadowRadius)
                .frame(maxHeight: decorator.viewMaxHeight)
                .shadow(radius: decorator.viewCornerShadowRadius)
                .transition(.scale)
                .onTapGesture { /* silent is gold */ }
            }
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

// MARK: - Preview
struct EditCompteView_Previews: PreviewProvider {
    static var previews: some View {
        let model = "Compte for testing purposes, Compte for testing"
        ZStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .background(.mint)

            RenameBoardView(model: model)
        }
    }
}
