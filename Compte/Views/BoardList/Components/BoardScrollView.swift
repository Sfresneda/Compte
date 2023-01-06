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
    var delete: (UUID) -> Void
    var rename: (CompteObject) -> Void
    
    private var firstItem: UUID? {
        items.first?.id
    }

    // MARK: Lifecycle
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach($items, id: \.id) { item in
                    NavigationLink(destination: ViewBuilderCoordinator
                        .shared
                        .buildTapListView(object: item.wrappedValue )) {
                            BoardListCellView(model: item)
                        }
                        .listRowInsets(EdgeInsets(top: .zero,
                                                  leading: .zero,
                                                  bottom: .zero,
                                                  trailing: 20))
                        .listRowSeparator(.hidden)
                        .swipeActions(allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation {
                                    delete(item.wrappedValue.id)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(Color.warning)

                            Button {
                                withAnimation {
                                    rename(item.wrappedValue)
                                }
                            } label: {
                                Image(systemName: "pencil.line")
                            }
                            .tint(Color.textSecondary)
                        }

                }
                .listRowBackground(Color.suplementaryBackground)
            }
            .listStyle(.plain)
            .onChange(of: items) { newValue in
                guard let firstId = firstItem else { return }
                withAnimation(.easeIn) {
                    proxy.scrollTo(firstId, anchor: .bottom)
                }
            }
        }
        .background(Color.grayBackground)
    }
}

// MARK: - Preview
struct BoardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        var items = Array(repeating: CompteObject.defaultImplementation(), count: 50)
        NavigationView {
            BoardScrollView(items: .constant(items)) { id in
                items.removeAll(where: { $0.id == id })
            } rename: { _ in
                // Silent is gold
            }
        }
    }
}
