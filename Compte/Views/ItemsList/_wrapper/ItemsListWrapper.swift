//
//  ItemsListWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 21/12/22.
//

import Foundation

// MARK: - ItemsListVModelProtocol
protocol ItemsListVModelProtocol: ObservableObject {
    var items: [CompteObject] { get set }
    var isItemsEmpty: Bool { get }
    var isEditNamePresented: Bool { get set }

    var selectedItem: CompteObject { get set }
    var selectedItemName: String { get }
    var navigationBarItems: [NavbarButton] { get set }
    
    var firstItemIdentifier: UUID? { get }

    func handleNavbarButton(_ button: NavbarButton)
    func add(with name: String?)
    func updateName(_ name: String)
    func delete(_ id: UUID)
}
