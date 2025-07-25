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
    @StateObject var vmodel: Model
    @State private var needsToShowAlert: Bool = false
    let decorator: TapListDecorator = DefaultTapListDecorator()

    // MARK: Lifecycle
    var body: some View {
        ZStack {
            VStack {
                if vmodel.isItemsEmpty {
                    VStack {
                        Spacer()
                        PlaceholderView(decorator: PlaceholderEmptyTapListDecorator())
                        Spacer()
                    }
                } else {
                    ScrollViewReader { proxy in
                        List {
                            Spacer()
                                .listRowBackground(Color.clear)
                                .listSectionSeparator(.hidden)
                                .foregroundColor(decorator.sectionForegroundColor)
                            ForEach(vmodel.items, id: \.id) { tap in
                                TapListCellView(model: tap)
                            }
                            .animation(.default, value: vmodel.items)
                            .listSectionSeparator(.hidden)
                            .listRowBackground(decorator.listRowBackgroundColor)
                        }
                        .listStyle(.plain)

                        .onChange(of: vmodel.numberOfTaps) { newValue in
                            guard let firstId = vmodel.firstItemIdentifier else { return }

                            withAnimation(decorator.scrollToTopAnimation) {
                                proxy.scrollTo(firstId, anchor: .bottom)
                            }
                        }
                    }
                }

                VStack {
                    HStack {
                        SlideToUnlockView(action: {
                            withAnimation(decorator.slideToUnlockAnimation) {
                                vmodel.cleanData()
                            }
                        })
                        Image(systemName: decorator.slideToUnlockImageName)
                            .font(decorator.slideToUnlockImageFont)
                            .foregroundColor(decorator.trashButtonColor)
                    }
                    .padding(decorator.slideToUnlockPadding)

                    TapView(buttonFont: {
                        decorator.tapButtonFont
                    }, maxWidth: {
                        decorator.tapButtonMaxWidth
                    }, action: {
                        withAnimation {
                            vmodel.add()
                        }
                    })
                    .background(decorator.tapButtonBackgroundColor)
                }
            }
            .safeAreaInset(edge: .top) {
                if !vmodel.isItemsEmpty {
                    withAnimation {
                        CounterView(currentValue: $vmodel.numberOfTaps)
                            .clipShape(Capsule())
                            .padding(decorator.counterViewPadding)
                            .scaledToFit()
                            .frame(maxHeight: decorator.counterViewMaxHeight)
                    }
                }
            }
        }
        .navigationTitle(vmodel.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(decorator.viewBackgroundColor)
    }
}

#Preview {
    let model = TapListVModel(
        modelObject: CompteObject(
            date: Date().timeIntervalSince1970,
            name: "example-name"
        )
    )

    TapListView(
        vmodel: model
    )
}
