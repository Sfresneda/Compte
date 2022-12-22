//
//  BoardListView.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import SwiftUI

// MARK: - BoardListView
struct BoardListView<Model>: View where Model: BoardListVModelProtocol {
    // MARK: Vars
    @ObservedObject var vmodel: Model
    
    // MARK: Lifecycle
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    BoardScrollView(items: $vmodel.items) { identifier in
                        vmodel.delete(identifier)
                    } rename: { object in
                        vmodel.selectedItem = object
                        toggleEditName()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        NavbarButtonsView(items: $vmodel.navigationBarItems) { button in
                            withAnimation {
                                vmodel.handleNavbarButton(button)
                            }
                        }
                    }

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
                RenameBoardView(model: vmodel.selectedItemName) {
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
private extension BoardListView {
    func toggleEditName() {
        vmodel.isEditNamePresented.toggle()
    }
}

// MARK: - Preview
struct BoardList_Previews: PreviewProvider {
    static var vmodel: BoardListVModel {
        let numberOfItems = 3
        let numberOfTaps = 80
        let model = BoardListVModel()
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
        BoardListView<BoardListVModel>(vmodel: BoardList_Previews.vmodel)
    }
}
