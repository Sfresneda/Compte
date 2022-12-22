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

    private enum Constants {
        static let maxNumberCharacters: Int = 50
        static let maxTextFieldHeight: CGFloat = 200
        static let viewCornerShadowRadius: CGFloat = 20
        static let viewMaxHeight: CGFloat = 300
        static let overlayColor: Color = .black.opacity(0.3)
        static let onAppearAnimation: Animation = .spring(dampingFraction: 0.75).delay(0.2)
        static let editorNormalColor: Color = .secondary
        static let editorWarningColor: Color = .red
        static let editorNormalFont: Font = .footnote
        static let editorWarningFont: Font = .title3
    }

    // MARK: Lifecycle
    var body: some View {
        VStack {
            if isPresented {
                VStack(alignment: .center) {
                    Text("Max. \(Constants.maxNumberCharacters) Characters")
                        .font(fontMaxCharactersLabel)
                        .foregroundColor(colorMaxCharactersLabel)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextEditor(text: $model)
                        .limitCharacters($model,
                                         limit: Constants.maxNumberCharacters,
                                         limitReached: { isReached in
                            withAnimation {
                                isMaxCharactersReached = isReached
                            }
                        })
                        .focused($isTextFieldFocused)
                        .submitLabel(.done)
                        .foregroundColor(.primary)
                        .font(.title2)

                    HStack(alignment: .center) {
                        Button {
                            onCancel?()
                        } label: {
                            Text("Cancel")
                        }
                        .tint(.gray)
                        .buttonStyle(.bordered)

                        Button {
                            onSubmit?(model)
                        } label: {
                            Text("Submit")
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                        .disabled(isMaxCharactersReached)
                    }
                }
                .padding()
                .background(.background)
                .cornerRadius(Constants.viewCornerShadowRadius)
                .frame(maxHeight: Constants.viewMaxHeight)
                .shadow(radius: Constants.viewCornerShadowRadius)
                .transition(.scale)
                .onTapGesture { /* silent is gold */ }
            }
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .center)
        .background(Constants.overlayColor)
        .onAppear {
            withAnimation(Constants.onAppearAnimation) {
                isPresented.toggle()
                isTextFieldFocused.toggle()
            }
        }
        .onTapGesture {
            onCancel?()
        }
    }
}
// MARK: - Helpers
private extension RenameBoardView {
    var colorMaxCharactersLabel: Color {
        isMaxCharactersReached
        ? Constants.editorWarningColor
        : Constants.editorNormalColor
    }
    var fontMaxCharactersLabel: Font {
        isMaxCharactersReached
        ? Constants.editorWarningFont
        : Constants.editorNormalFont
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
