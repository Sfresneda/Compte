//
//  PhoneSyncService.swift
//  Compte
//
//  Created by sergio fresneda on 3/15/26.
//

import Foundation
import Combine
import WatchConnectivity

final class PhoneSyncService: NSObject, ObservableObject {
    static let shared = PhoneSyncService()

    private let dataManager: any PersistenceManagerProtocol
    private var cancellable: AnyCancellable?
    private var session: WCSession? {
        WCSession.isSupported()
        ? .default
        : nil
    }

    init(dataManager: any PersistenceManagerProtocol = PersistenceManager.shared) {
        self.dataManager = dataManager
    }

    func start() {
        guard let session else { return }

        session.delegate = self
        session.activate()

        cancellable = dataManager
            .compteModelPublisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] _ in
                self?.pushSnapshotToWatch()
            })
    }

    func pushSnapshotToWatch() {
        guard let session, session.isReachable else { return }

        let boards = dataManager.compteModelCollection
            .map {
                BoardSnapshot(
                    id: $0.id,
                    name: $0.name,
                    tapCount: $0.taps.count,
                    lastModified: $0.lastModified
                )
            }.sorted { $0.lastModified > $1.lastModified }

        let payload = WatchPayload(
            boards: boards,
            generatedAt: Date().timeIntervalSince1970
        )


        do {
            let context = try WCCodec.encodePayload(payload)
            try session.updateApplicationContext(context)
        } catch {
            debugPrint("error sending the context \(error) - \(String(describing: payload))")
        }
    }

    func handleIncoming(_ dictionary: [String: Any]) {
        do {
            let command = try WCCodec.decodeCommand(dictionary)
            Task { @MainActor [weak self] in
                self?.apply(command)
            }
        } catch {
            debugPrint("Error decoding command: \(error)")
        }
    }

    @MainActor
    func apply(_ command: WatchCommand) {
        switch command {
        case .incrementTap(let boardId):
            guard let board = dataManager.compteModelCollection.first(where: { $0.id == boardId }) else { return }

            let tap = TapObject(
                date: Date().timeIntervalSince1970,
                tapNumber: board.taps.count + 1,
                parentId: boardId
            )

            dataManager.add(mapper: TapMapper(tap), requireSave: true)
            pushSnapshotToWatch()
        }
    }
}

extension PhoneSyncService: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: (any Error)?
    ) {
        if activationState == .activated {
            pushSnapshotToWatch()
        }
    }

    func session(
        _ session: WCSession,
        didReceiveMessage message: [String : Any]
    ) {
        handleIncoming(message)
    }

    func session(
        _ session: WCSession,
        didReceiveUserInfo userInfo: [String : Any] = [:]
    ) {
        handleIncoming(userInfo)
    }
}
