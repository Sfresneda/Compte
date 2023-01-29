//
//  BoardScrollView.swift
//  Compte
//
//  Created by likeadeveloper on 21/12/22.
//

import SwiftUI

// MARK: - BoardScrollView
struct BoardScrollView: View {
    // MARK: Vars
    @Binding var items: [CompteObject]
    @Binding var multiSelection: Set<UUID>

    var delete: (UUID) -> Void
    var rename: (CompteObject) -> Void
    var decorator: BoardScrollDecorator = DefaultBoardScrollDecorator()

    private var firstItem: UUID? {
        items.first?.id
    }

    // MARK: Lifecycle
    var body: some View {
        ScrollViewReader { proxy in
            List($items, selection: $multiSelection) { item in
                    NavigationLink(destination: ViewBuilderCoordinator
                        .shared
                        .buildTapListView(object: item.wrappedValue )) {
                            BoardListCellView(model: item)
                        }
                    .listRowInsets(decorator.listRowInsets)
                    .listRowSeparator(.hidden)
                    .listRowBackground(CardCellBackgroundView())
                    .swipeActions(allowsFullSwipe: false) {
                         Button(role: .destructive) {
                             withAnimation {
                                 delete(item.wrappedValue.id)
                             }
                         } label: {
                             decorator.swipeDeleteActionLabel
                         }
                         .tint(decorator.swipeDeleteTint)

                         Button {
                             withAnimation {
                                 rename(item.wrappedValue)
                             }
                         } label: {
                             decorator.swipeRenameActionLabel
                         }
                         .tint(decorator.swipeRenameTint)
                     }
            }
            .listStyle(.plain)
            .onChange(of: items) { newValue in
                guard let firstId = firstItem else { return }
                withAnimation(.easeIn) {
                    proxy.scrollTo(firstId, anchor: .bottom)
                }
            }
        }
        .background(decorator.backgroundColor)
    }
}
