//
//  LimitedTextEditorView.swift
//  Compte
//
//  Created by likeadeveloper on 22/12/22.
//

import SwiftUI
// MARK: - LimitedTextEditorView
struct LimitedTextEditorView: ViewModifier {
    // MARK: Vars
    @Binding var text: String
    var charactersLimit: Int
    var limitReached: ((Bool) -> Void)? = nil

    private enum Constants {
        static let charactersLimitOffset: Int = 1
    }

    // MARK: Lifecycle
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { newValue in
                let limitedText = String(newValue
                    .prefix(charactersLimit + Constants.charactersLimitOffset))
                    .trimmingCharacters(in: .newlines)
                    .replacingOccurrences(of: "\\s*\\n\\s*|^\\s+",
                                          with: " ",
                                          options: .regularExpression)

                text = limitedText

                let isReached = limitedText.count > charactersLimit
                limitReached?(isReached)
            }
    }
}
// MARK: - Modifier
extension View {
    func limitCharacters(_ text: Binding<String>,
                         limit: Int,
                         limitReached: ((Bool) -> Void)? = nil) -> some View {
        modifier(LimitedTextEditorView(text: text,
                                       charactersLimit: limit,
                                       limitReached: limitReached))
    }
}
