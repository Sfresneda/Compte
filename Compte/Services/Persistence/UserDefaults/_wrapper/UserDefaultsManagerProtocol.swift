//
//  UserDefaultsManagerProtocol.swift
//  Compte
//
//  Created by likeadeveloper on 6/5/23.
//

import Foundation

protocol UserDefaultsManagerProtocol {
    static var shared: UserDefaultsManagerProtocol { get }
    
    func purgue()
    func toogleFocusMode()
    func getFocusMode() -> Bool
}
