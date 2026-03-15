//
//  WatchSyncStore.swift
//  Compte Watch Watch App
//
//  Created by sergio fresneda on 3/15/26.
//

import Combine
import Foundation
import WatchConnectivity

@MainActor
final class WatchSyncStore: NSObject, ObservableObject {
    @Published var boards: [BoardSnapshot] = []
    @Published var lastSyncDate: Date?
    @Published var isReachable: Bool = true

    private var session: WCSession? {
        WCSession.isSupported()
        ? .default
        : nil
    }

    func start() {
        guard let session else { return }
        session.delegate = self
        session.activate()

        applyContext(session.receivedApplicationContext)
    }

    func incrementTap(boardId: UUID) {
        guard let session else { return }

        do {
            let message = try WCCodec.encodeCommand(.incrementTap(boardId: boardId))
            if session.isReachable {
                session.sendMessage(message, replyHandler: nil) { error in
                    debugPrint("Error sending message: \(error.localizedDescription)")
                }
            } else {
                session.transferUserInfo(message)
            }
        } catch {
            debugPrint("WatchSyncStore encode error: \(error)")
        }
    }
}

private extension WatchSyncStore {
    func applyContext(_ context: [String: Any]) {
        guard !context.isEmpty else { return }

        do {
            let payload = try WCCodec.decodePayload(context)
            boards = payload.boards.sorted { $0.lastModified > $1.lastModified }
            lastSyncDate = Date(timeIntervalSince1970: payload.generatedAt)
        } catch {
            debugPrint("WatchSyncStore decode error: \(error)")
        }
    }
}

extension WatchSyncStore: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        Task { @MainActor in
            self.isReachable = session.isReachable
            self.applyContext(session.receivedApplicationContext)
        }
    }

    nonisolated
    func sessionReachabilityDidChange(_ session: WCSession) {
        Task { @MainActor in
            self.isReachable = session.isReachable
        }
    }

    nonisolated
    func session(
        _ session: WCSession,
        didReceiveApplicationContext applicationContext: [String : Any]
    ) {
        Task { @MainActor in
            self.applyContext(applicationContext)
        }
    }
}
