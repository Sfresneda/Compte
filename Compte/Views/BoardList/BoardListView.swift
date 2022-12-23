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
    let decorator: BoardListDecorator = DefaultBoardListDecorator()

    // MARK: Lifecycle
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if vmodel.isItemsEmpty {
                        PlaceholderView(decorator: PlaceholderEmptyBoardListDecorator()) { action in
                            if .addNewBoard == action {
                                withAnimation {
                                    vmodel.add(with: nil)
                                }
                            }
                        }
                    } else {
                        ZStack {
                            BoardScrollView(items: $vmodel.items) { identifier in
                                vmodel.delete(identifier)
                            } rename: { object in
                                vmodel.selectedItem = object
                                toggleEditName()
                            }
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
                                    Text(decorator.tapViewTextTitle)
                                } buttonFont: {
                                    .system(size: 20)
                                } action: {
                                    withAnimation { vmodel.add(with: nil) }
                                }
                                .background(decorator.tapViewBackgroundColor)
                                .clipShape(Capsule())
                                .shadow(radius: decorator.tapViewShadowRadius)
                                .padding(decorator.tapViewPadding)
                            }
                        }
                    }
                }
                .navigationTitle(decorator.navigationBarTitle)
                .navigationBarTitleDisplayMode(decorator.navigationBarTitleDisplayMode)
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
        let numberOfItems = 4
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

struct EMPTY_Previews: PreviewProvider {
    static var vmodel: BoardListVModel {
        let model = BoardListVModel()
        model.items = []
        return model
    }
    static var previews: some View {
        BoardListView<BoardListVModel>(vmodel: EMPTY_Previews.vmodel)
    }
}
