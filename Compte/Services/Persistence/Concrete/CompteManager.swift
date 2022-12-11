//
//  CompteManager.swift
//  Compte
//
//  Created by likeadeveloper on 11/12/22.
//

import Foundation
import CoreData
import Combine

final class CompteManager: PersistenceManager<CompteEntity> {
    override init(container: NSPersistentContainer) {
        super.init(container: container)
        modelFetcherController.delegate = self
    }
    
    override func add(_ model: CompteEntity, requireSave: Bool = false) {
        super.add(model, requireSave: requireSave)
    }
    override func update(_ id: UUID, requireSave: Bool = false) {
        super.update(id, requireSave: requireSave)
    }
    override func delete(_ id: UUID, requireSave: Bool = false) {
        super.delete(id, requireSave: requireSave)
    }
    override func clearAll(requireSave: Bool = false) {
        super.clearAll(requireSave: requireSave)
    }
}

extension CompteManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let models = controller.fetchedObjects as? [CompteEntity] else {
            return
        }
        self.models.value = models
    }
}
