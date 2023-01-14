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

    init(vmodel: Model) {
        self.vmodel = vmodel
        UINavigationBar.appearance().tintColor = decorator.navigationBarTintColor
        UINavigationBar.appearance().largeTitleTextAttributes = decorator.navigationBarLargeTitleAttributes
        UINavigationBar.appearance().titleTextAttributes = decorator.navigationBarTitleAttributes
    }

    // MARK: Lifecycle
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if vmodel.isItemsEmpty {
                        PlaceholderView(decorator: PlaceholderEmptyBoardListDecorator()) { action in
                            if .addNewBoard == action { vmodel.renameViewInvocationAction(.new) }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ZStack {
                            BoardScrollView(items: $vmodel.items) { identifier in
                                vmodel.delete(identifier)
                            } rename: { object in
                                vmodel.renameViewInvocationAction(.edit(object))
                            }
                            .toolbar {
                                NavbarButtonsView(items: $vmodel.navigationBarItems) { button in
                                    withAnimation { vmodel.handleNavbarButton(button) }
                                }
                            }

                            VStack {
                                Spacer()
                                TapView {
                                    Text(decorator.tapViewTextTitle)
                                        .bold()
                                } buttonFont: {
                                    decorator.tapViewFont
                                } action: {
                                    withAnimation { vmodel.renameViewInvocationAction(.new) }
                                }
                                .background(decorator.tapViewBackgroundColor)
                                .clipShape(Capsule())
                                .shadow(radius: decorator.tapViewShadowRadius)
                                .padding(decorator.tapViewPadding)
                            }
                        }
                    }
                }
                .background(decorator.viewBackgroundColor)
                .navigationTitle(decorator.navigationBarTitle)
                .navigationBarTitleDisplayMode(decorator.navigationBarTitleDisplayMode)
            }
            .accentColor(decorator.navigationBarAccentColor)

            if vmodel.isRenameViewPresented {
                RenameCardView(model: vmodel.objectToRename?.name ?? "") {
                    vmodel.renameViewInvocationAction(.done)
                } onSubmit: { newName in
                    withAnimation(.easeIn) {
                        if vmodel.isAnObjectToRename {
                            vmodel.renameViewSubmitAction(.update(newName))
                        } else {
                            vmodel.renameViewSubmitAction(.add(newName))
                        }
                    }
                }
            }
        }
    }
}
