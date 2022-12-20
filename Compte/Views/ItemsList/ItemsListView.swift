//
//  ItemsListView.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import SwiftUI

struct ItemsListView<Model>: View where Model:
ItemsListVModelProtocol {
    // MARK: Vars
    @ObservedObject var vmodel: Model

    // MARK: Body
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach($vmodel.items, id: \.id) { item in
                        ZStack {
                            NavigationLink(destination: ViewBuilderCoordinator
                                .shared
                                .buildTapListView(object: item.wrappedValue )) {
                                    ItemsListCell(model: item) { identifier in
                                        vmodel.delete(identifier)
                                    } onRename: {
                                        vmodel.selectedItem = item.wrappedValue
                                        toggleEditName()
                                    }
                                }
                        }
                    }
                }
                .toolbar {
                    MainNavbarButtonsView(items: [.new]) { action in
                        if action == .new {
                            vmodel.add(with: nil)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            if vmodel.isEditNamePresented {
                EditCompteView(model: vmodel.selectedItemName) {
                    toggleEditName()
                } onSubmit: { newName in
                    defer { toggleEditName() }

                    withAnimation {
                        vmodel.updateName(newName)
                    }
                }
            }
        }
    }
}
// MARK: - Helpers
private extension ItemsListView {
    func toggleEditName() {
        vmodel.isEditNamePresented.toggle()
    }
}
// MARK: - Preview
struct ItemsList_Previews: PreviewProvider {
    static var previews: some View {
        let model = ItemsListVModel()
        ItemsListView<ItemsListVModel>(vmodel: model)
    }
}
