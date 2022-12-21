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
                            BoardListCell(model: item) { identifier in
                                delete(identifier)
                            } onRename: {
                                rename(item.wrappedValue)
                            }
                        }
                }
            }
            .onChange(of: items) { newValue in
                guard let firstId = firstItem else { return }
                withAnimation(.easeIn) {
                    proxy.scrollTo(firstId, anchor: .bottom)
                }
            }
        }
    }
}

// MARK: - Preview
struct BoardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        var items = Array(repeating: CompteObject.defaultImplementation(), count: 50)
        BoardScrollView(items: .constant(items)) { id in
            items.removeAll(where: { $0.id == id })
        } rename: { _ in
            // Silent is gold
        }

    }
}
