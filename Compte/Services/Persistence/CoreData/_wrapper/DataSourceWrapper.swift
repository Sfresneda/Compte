//
//  DataSourceWrapper.swift
//  Compte
//
//  Created by likeadeveloper on 27/12/22.
//

import Foundation
import CoreData

protocol DataStoreProtocol {
    var container: NSPersistentContainer { get }
    var context: NSManagedObjectContext { get }

    func save()
}
