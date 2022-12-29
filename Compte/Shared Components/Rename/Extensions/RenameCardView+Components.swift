//
//  RenameCardView+Components.swift
//  Compte
//
//  Created by likeadeveloper on 29/12/22.
//

import Foundation
import SwiftUI

extension RenameCardView {
    // MARK: CardView
    @ViewBuilder
    func cardView() -> some View {
        if isPresented {
            VStack(alignment: .center) {
                limitCharactersView()
                ZStack {
                    textEditorView()
                    placeholderView()
                }
                HStack(alignment: .center) {
                    cardButtons()
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
    // MARK: limitCharactersView
    @ViewBuilder
    func limitCharactersView() -> some View {
        Text(decorator.limitCharsText)
            .font(decorator.limitCharsLabelFont(isMaxCharactersReached))
            .foregroundColor(decorator.limitCharsLabelColor(isMaxCharactersReached))
            .frame(maxWidth: decorator.limitCharsMaxWidth,
                   alignment: decorator.limitCharsAligment)
    }
    // MARK: textEditorView
    @ViewBuilder
    func textEditorView() -> some View {
        TextEditor(text: $model)
            .limitCharacters($model,
                             limit: decorator.limitChars,
                             limitReached: { isReached in
                withAnimation {
                    setMaxCharactersReached(isReached)
                }
            })
            .focused($isTextFieldFocused)
            .submitLabel(decorator.limitCharsSubmitButtonType)
            .foregroundColor(decorator.limitCharsForegroundColor)
            .font(decorator.limitCharsFont)
            .cornerRadius(decorator.textEditorCornerRadius)
    }
    // MARK: cardButtons
    @ViewBuilder
    func cardButtons() -> some View {
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
    // MARK: placeholderView
    @ViewBuilder
    func placeholderView() -> some View {
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
}

