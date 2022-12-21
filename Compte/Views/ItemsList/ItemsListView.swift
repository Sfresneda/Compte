//
//  ItemsListView.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import SwiftUI

// MARK: - Lifecycle
struct ItemsListView<Model>: View where Model: ItemsListVModelProtocol {
    // MARK: Vars
    @ObservedObject var vmodel: Model
    
    // MARK: Body
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    ScrollViewReader { proxy in
                        List {
                            ForEach($vmodel.items, id: \.id) { item in
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
                        .onChange(of: vmodel.items) { newValue in
                            guard let firstId = vmodel.firstItemIdentifier else { return }
                            withAnimation(.easeIn) {
                                proxy.scrollTo(firstId, anchor: .bottom)
                            }
                        }
                        .toolbar {
                            //                            if !vmodel.isItemsEmpty { EditButton() }
                            NavbarButtonsView(items: $vmodel.navigationBarItems) { button in
                                withAnimation {
                                    vmodel.handleNavbarButton(button)
                                }
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    
                    VStack {
                        Spacer()
                        TapView {
                            Text("Add New Compte")
                        } buttonFont: {
                            .system(size: 20)
                        } action: {
                            withAnimation { vmodel.add(with: nil) }
                        }
                        .background(.blue)
                        .clipShape(Capsule())
                        .shadow(radius: 10)
                    }
                }
            }
            
            if vmodel.isEditNamePresented {
                EditCompteView(model: vmodel.selectedItemName) {
                    toggleEditName()
                } onSubmit: { newName in
                    defer { toggleEditName() }
                    withAnimation(.easeIn) {
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
    static var vmodel: ItemsListVModel {
        let numberOfItems = 3
        let numberOfTaps = 80
        let model = ItemsListVModel()
        model.items = (0..<numberOfItems).map {_ in
            CompteObject(id: UUID(),
                         date: Date().timeIntervalSince1970,
                         name: String(UUID().uuidString.prefix(Int.random(in: 0..<50))),
                         taps: Array(repeating: TapObject.defaultImplementation(),
                                     count: numberOfTaps))
        }
        return model
    }
    static var previews: some View {
        ItemsListView<ItemsListVModel>(vmodel: ItemsList_Previews.vmodel)
    }
}
