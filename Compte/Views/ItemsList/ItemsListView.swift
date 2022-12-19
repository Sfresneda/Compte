//
//  ItemsListView.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import SwiftUI

struct ItemsListView<Model>: View where Model: ItemsListVModelProtocol {
    @ObservedObject var model: Model

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach($model.items, id: \.id) { item in
                        ZStack {
                            NavigationLink(destination: ViewBuilderCoordinator
                                .shared
                                .buildMainView(compteModel: item.wrappedValue)) {
                                    ItemsListCell(model: item) { identifier in
                                        model.delete(with: identifier)
                                    } onRename: {
                                        model.selectedItem = item.wrappedValue
                                        toggleEditName()
                                    }
                                }
                        }
                    }
                }
                .toolbar {
                    MainNavbarButtonsView(items: [.new]) { action in
                        if action == .new {
                            model.add(with: nil)
                        }
                    }
                }
            }
            if model.isEditNamePresented {
                EditCompteView(model: model.selectedItemName) {
                    toggleEditName()
                } onSubmit: { newName in
                    defer { toggleEditName() }

                    withAnimation {
                        model.updateName(newName)
                    }
                }
            }
        }
    }
}

private extension ItemsListView {
    func toggleEditName() {
        model.isEditNamePresented.toggle()
    }
}

struct ItemsList_Previews: PreviewProvider {
    static var previews: some View {
        let model = ItemsListVModel()
        ItemsListView<ItemsListVModel>(model: model)
    }
}
