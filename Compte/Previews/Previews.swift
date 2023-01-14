//
//  Previews.swift
//  Compte
//
//  Created by likeadeveloper on 14/1/23.
//

import SwiftUI

// MARK: - BoardList
struct BoardList_Previews: PreviewProvider {
    static var vmodel: BoardListVModel<PersistenceManager> {
        let numberOfItems = 4
        let numberOfTaps = 100
        let model = BoardListVModel<PersistenceManager>()
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
struct EmptyBoardList_Previews: PreviewProvider {
    static var vmodel: BoardListVModel<PersistenceManager> {
        let model = BoardListVModel<PersistenceManager>()
        model.items = []
        return model
    }
    static var previews: some View {
        BoardListView<BoardListVModel>(vmodel: EmptyBoardList_Previews.vmodel)
    }
}

// MARK: - BoardListCell
struct BoardListCell_Previews: PreviewProvider {
    static var previews: some View {
        let numberOfTaps: Int = 100
        let tapsCollection = Array(repeating: TapObject(date: Date().timeIntervalSince1970,
                                                        tapNumber: .zero),
                                   count: numberOfTaps)
        let model = CompteObject(id: nil,
                                 date: Date().timeIntervalSince1970,
                                 name: "test",
                                 taps: tapsCollection,
                                 lastModified: Date().timeIntervalSince1970)
        BoardListCellView(model: .constant(model))
    }
}

// MARK: - BoardScrollView
struct BoardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        var items = Array(repeating: CompteObject.defaultImplementation(), count: 50)
        NavigationView {
            BoardScrollView(items: .constant(items)) { id in
                items.removeAll(where: { $0.id == id })
            } rename: { _ in
                // Silent is gold
            }
        }
    }
}

// MARK: - TapListCellView
struct TapListCellView_Previews: PreviewProvider {
    static var previews: some View {
        let model = TapObject(date: Date().timeIntervalSince1970,
                             tapNumber: 1)
        TapListCellView(model: model)
    }
}

// MARK: - TapListView
struct TapListView_Previews: PreviewProvider {
    static var model: TapListVModel<PersistenceManager> {
        let model = TapListVModel(modelObject: CompteObject.defaultImplementation())
        model.numberOfTaps = 1
        model.items = Array<TapObject>
            .init(repeating: TapObject(date: Date().timeIntervalSince1970,
                                       tapNumber: 1),
                  count: 1)
        return model
    }
    static var previews: some View {
        NavigationView {
            TapListView(vmodel: model)
        }
    }
}
struct EmptyWTapListView_Previews: PreviewProvider {
    static let model = TapListVModel(modelObject: CompteObject(date: Date().timeIntervalSince1970,
                                                               name: "example-name"))
    static var previews: some View {
        NavigationView {
            TapListView(vmodel: model)
        }
    }
}

// MARK: - NavbarButtonsView
struct NavbarButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavbarButtonsView(items: .constant(NavbarButton.allCases),
                          action: { _ in /* Silent is golden */ })
    }
}

// MARK: - RenameCardView
struct RenameCardView_Previews: PreviewProvider {
    static var previews: some View {
        let model = "Compte for testing purposes, Compte for testing"
        ZStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .background(.mint)

            RenameCardView(model: model)
        }
    }
}
struct EmptyRenameCardView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ""
        ZStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .background(.mint)

            RenameCardView(model: model)
        }
    }
}

// MARK: - CounterView
struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image(systemName: "pencil")
                .resizable()
                .scaledToFit()
            CounterView(currentValue: .constant(1))
        }
    }
}

// MARK: - LimitedTextEditorView
struct LimitedTextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        let text: Binding<String> = .constant("hollla")
        TextEditor(text: text)
            .limitCharacters(text,
                             limit: 50) { _ in
                fatalError()
            }
    }
}

// MARK: - SlideToUnlockView
struct SlideToUnlockView_Previews: PreviewProvider {
    static var previews: some View {
        SlideToUnlockView()
    }
}

// MARK: - TapView
struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image(systemName: "person.2.wave.2")
                .resizable()
                .scaledToFill()
            TapView(representation: {
                Text("Add New Compte")
            }, buttonFont: { .system(size: 50) })
            .background(.blue)
            .clipShape(Capsule())
            .shadow(radius: 10)
            .padding()
        }
    }
}
struct MAXWIDTHTapView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image(systemName: "person.2.wave.2")
                .resizable()
                .scaledToFill()
            TapView(buttonFont: {
                .system(size: 50)
            }, maxWidth: { .infinity })
            .background(.blue)
            .clipShape(Capsule())
            .shadow(radius: 10)
            .padding()
        }
    }
}

// MARK: - PlaceholderEmptyBoardListView
struct PlaceholderEmptyBoardListView_Previews: PreviewProvider {
    static var previews: some View {
        let decorator = PlaceholderEmptyBoardListDecorator()
        PlaceholderView(decorator: decorator)
    }
}
struct PlaceholderEmptyTapListView_Previews: PreviewProvider {
    static var previews: some View {
        let decorator = PlaceholderEmptyTapListDecorator()
        PlaceholderView(decorator: decorator)
    }
}
