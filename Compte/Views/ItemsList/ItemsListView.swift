//
//  ItemsListView.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import SwiftUI

struct ItemsListView: View {
    @StateObject var model: ItemsListVModel
    @State private var showAlert: Bool = false
    @State private var newItemName: String?

    var body: some View {
        NavigationView {
            List {
                ForEach(model.items, id: \.id) { item in
                    Text(item.name ?? "--")
                }
                if !model.items.isEmpty {
                    Button {
                        model.clear()
                    } label: {
                        Text("Remove all")
                    }
                }
            }
            .toolbar {
                MainNavbarButtonsView { action in
                    if action == .new {
                        model.add(with: nil)
                    }
                }
            }
        }
    }
}

struct ItemsList_Previews: PreviewProvider {
    static var previews: some View {
        let model = ItemsListVModel(dataManager: nil)
        ItemsListView(model: model)
    }
}
