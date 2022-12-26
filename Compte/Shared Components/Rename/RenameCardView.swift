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
    @State private var isPresented: Bool = false
    var onCancel: (() -> Void)?
    var onSubmit: ((String) -> Void)?
    @FocusState private var isTextFieldFocused: Bool
    @State private var isMaxCharactersReached: Bool = false
    let decorator: RenameBoardDecorator = DefaultRenameBoardDecorator()

    init(model: String, onCancel: ( () -> Void)? = nil, onSubmit: ( (String) -> Void)? = nil) {
        self.model = model
        self.isPresented = isPresented
        self.onCancel = onCancel
        self.onSubmit = onSubmit
        self.isTextFieldFocused = isTextFieldFocused
        self.isMaxCharactersReached = isMaxCharactersReached

        UITextView.appearance().backgroundColor = .clear
    }

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
                    ZStack {
                        TextEditor(text: $model)
                            .limitCharacters($model, limit: decorator.limitChars, limitReached: { isReached in
                                withAnimation {
                                    isMaxCharactersReached = isReached
                                }
                            })
                            .focused($isTextFieldFocused)
                            .submitLabel(decorator.limitCharsSubmitButtonType)
                            .foregroundColor(decorator.limitCharsForegroundColor)
                            .font(decorator.limitCharsFont)
                            .cornerRadius(decorator.textEditorCornerRadius)

                        if model.isEmpty {
                            Text(NSLocalizedString("rename_placeholder_text",
                                                   comment: "rename placeholder text"))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.secondary)
                                .font(decorator.limitCharsFont)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(EdgeInsets(top: 8, leading: 5, bottom: 0, trailing: 0))
                        }
                    }
                    HStack(alignment: .center) {
                        Button {
                            onCancel?()
                        } label: {
                            Text(decorator.cancelButtonText)
                        }
                        .tint(decorator.cancelButtonTintColor)
                        .buttonStyle(.bordered)

                        Button {
                            onSubmit?(model)
                        } label: {
                            Text(decorator.submitButtonText)
                        }
                        .tint(decorator.submitButtonTintColor)
                        .buttonStyle(.bordered)
                        .disabled(isMaxCharactersReached || model.isEmpty)
                    }
                }
                .padding()
                .background(decorator.viewBackgroundColor)
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

            RenameCardView(model: model)
        }
    }
}

struct EmptyEditCompteView_Previews: PreviewProvider {
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