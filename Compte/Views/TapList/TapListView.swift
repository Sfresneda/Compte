//
//  TapListView.swift
//  Compte
//
//  Created by likeadeveloper on 6/12/22.
//

import SwiftUI

// MARK: - TapListView
struct TapListView<Model>: View where Model: TapListVModelProtocol {
    // MARK: Vars
    @ObservedObject var vmodel: Model
    @State private var needsToShowAlert: Bool = false
    let decorator: TapListDecorator = DefaultTapListDecorator()

    // MARK: Lifecycle
    var body: some View {
        ZStack {
            VStack {
                ScrollViewReader { proxy in
                    Form {
                        Section(decorator.sectionTitle) {
                            ForEach(vmodel.items, id: \.id) { tap in
                                TapListCellView(model: tap)
                            }
                        }
                        .animation(.default, value: vmodel.items)
                    }
                    .onChange(of: vmodel.numberOfTaps) { newValue in
                        guard let firstId = vmodel.firstItemIdentifier else { return }

                        withAnimation(decorator.scrollToTopAnimation) {
                            proxy.scrollTo(firstId, anchor: .bottom)
                        }
                    }
                }
                VStack {
                    HStack {
                        SlideToUnlockView(action: {
                            withAnimation(decorator.slideToUnlockAnimation) { vmodel.cleanData()}
                        })
                        Image(systemName: decorator.slideToUnlockImageName)
                            .font(decorator.slideToUnlockImageFont)
                    }
                    .padding(decorator.slideToUnlockPadding)

                    TapView(buttonFont: {
                        decorator.tapButtonFont
                    }, maxWidth: {
                        decorator.tapButtonMaxWidth
                    }, action: {
                        vmodel.add()
                    })
                    .background(decorator.tapButtonBackgroundColor)
                }
            }
            .safeAreaInset(edge: .top) {
                withAnimation {
                    CounterView(currentValue: $vmodel.numberOfTaps)
                        .clipShape(Capsule())
                        .padding(decorator.counterViewPadding)
                        .scaledToFit()
                        .frame(maxHeight: decorator.counterViewMaxHeight)
                }
            }
        }
        .navigationTitle(vmodel.name)
    }
}
// MARK: - Helpers
private extension TapView {}

// MARK: - Preview
struct TapListView_Previews: PreviewProvider {
    static var previews: some View {
        let model = TapListVModel(modelObject: CompteObject.defaultImplementation())
        model.numberOfTaps = 1
        model.items = Array<TapObject>
            .init(repeating: TapObject(date: Date().timeIntervalSince1970,
                                       tapNumber: 1),
                  count: 1)
        return TapListView(vmodel: model)
    }
}
