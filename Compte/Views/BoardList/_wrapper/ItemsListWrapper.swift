//
//  BoardListWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 21/12/22.
//

import Foundation

enum RenameViewPresentingAction {
    case new
    case edit(CompteObject)
    case done
}
enum RenameViewSubmitAction {
    case add(String)
    case update(String)
}

// MARK: - BoardListVModelProtocol
protocol BoardListVModelProtocol: ObservableObject {
    var items: [CompteObject] { get set }
    var isItemsEmpty: Bool { get }
    var isRenameViewPresented: Bool { get }

    var navigationBarItems: [NavbarButton] { get set }
    var firstItemIdentifier: UUID? { get }
    var objectToRename: CompteObject? { get }
    var isAnObjectToRename: Bool { get }

    func renameViewInvocationAction(_ action: RenameViewPresentingAction)
    func renameViewSubmitAction(_ action: RenameViewSubmitAction)

    func handleNavbarButton(_ button: NavbarButton)
    func delete(_ id: UUID)
}
