//
//  PlaceholderView.swift
//  Compte
//
//  Created by likeadeveloper on 23/12/22.
//

import SwiftUI

// MARK: - PlaceholderView
struct PlaceholderView<Decorator>: View where Decorator: PlaceholderDecorator {
    // MARK: Vars
    let decorator: Decorator
    var action: ((PlaceholderAction) -> Void)? = nil
    @State private var animate: Bool = false

    // MARK: Lifecycle
    var body: some View {
        decorator
            .content({ animate }())
            .onAppear {
                DispatchQueue.main.async {
                    decorator.animation({
                        self.animate.toggle()
                    }())
                }
            }
            .onTapGesture {
                action?(.addNewBoard)
            }
    }
}

// MARK: - Preview
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
