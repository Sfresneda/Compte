//
//  ContentView.swift
//  Compte Watch Watch App
//
//  Created by sergio fresneda on 3/15/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var syncStore: WatchSyncStore

    var body: some View {
        NavigationStack {
            Group {
                if syncStore.boards.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "applewatch.radiowaves.left.and.right")
                            .font(.title2)
                        Text("Sin datos")
                            .font(.headline)
                        Text("Abre Compte en iPhone para sincronizar.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                } else {
                    List(syncStore.boards) { board in
                        NavigationLink(value: board) {
                            BoardRowView(board: board)
                        }
                    }
                    .listStyle(.carousel)
                }
            }
            .navigationTitle("Compte")
            .navigationDestination(for: BoardSnapshot.self) { board in
                BoardDetailView(boardId: board.id)
            }
        }
    }
}
private struct BoardRowView: View {
    let board: BoardSnapshot
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(board.name)
                .font(.headline)
                .lineLimit(1)
            Text("\(board.tapCount) taps")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}

private struct BoardDetailView: View {
    let boardId: UUID
    @EnvironmentObject private var syncStore: WatchSyncStore
    private var board: BoardSnapshot? {
        syncStore.boards.first(where: { $0.id == boardId })
    }
    var body: some View {
        VStack(spacing: 10) {
            Text(board?.name ?? "Board")
                .font(.headline)
                .multilineTextAlignment(.center)
            Text("\(board?.tapCount ?? 0)")
                .font(.system(size: 36, weight: .bold, design: .rounded))
            Text("Taps")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Button("Tap") {
                syncStore.incrementTap(boardId: boardId)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Detalle")
    }
}
