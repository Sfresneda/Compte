//
//  EditCompteView.swift
//  Compte
//
//  Created by likeadeveloper on 19/12/22.
//

import SwiftUI

struct EditCompteView: View {
    @State var model: String {
        didSet {
            debugPrint(model.count)
        }
    }
    @State private var isPresented: Bool = false
    var onCancel: (() -> Void)?
    var onSubmit: ((String) -> Void)?
    @FocusState private var isTextFieldFocused: Bool

    private enum Constants {
        static let maxNumberCharacters: Int = 50
        static let maxNumberOfLines: Int = 3
        static let viewCornerShadowRadius: CGFloat = 20
        static let viewMaxHeight: CGFloat = 300
        static let overlayColor: Color = .black.opacity(0.3)
        static let onAppearAnimation: Animation = .spring(dampingFraction: 0.75).delay(0.2)
    }

    var body: some View {
        VStack {
            if isPresented {
                VStack(alignment: .center) {
                    Text("Max. \(Constants.maxNumberCharacters) Characters")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("Title",
                              text: $model,
                              axis: .vertical)
                    .focused($isTextFieldFocused)
                    .submitLabel(.done)
                    .foregroundColor(.primary)
                    .lineLimit(Constants.maxNumberOfLines, reservesSpace: true)
                    .font(.title2)
                    .padding()

                    HStack(alignment: .center) {
                        Button {
                            onCancel?()
                        } label: {
                            Text("Cancel")
                        }
                        .tint(.gray)
                        .buttonStyle(.bordered)

                        Button {
                            onSubmit?(String(model.prefix(Constants.maxNumberCharacters)))
                        } label: {
                            Text("Submit")
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(.background)
                .cornerRadius(Constants.viewCornerShadowRadius)
                .frame(maxHeight: Constants.viewMaxHeight)
                .shadow(radius: Constants.viewCornerShadowRadius)
                .transition(.scale)
                .onTapGesture { /* silent is gold */ }
            }
        }
        .padding()
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .center)
        .background(Constants.overlayColor)
        .onAppear {
            withAnimation(Constants.onAppearAnimation) {
                isPresented.toggle()
                isTextFieldFocused.toggle()
            }
        }
        .onTapGesture {
            onCancel?()
        }
    }
}

struct EditCompteView_Previews: PreviewProvider {
    static var previews: some View {
        let model = "Compte for testing purposes"
        ZStack {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .background(.mint)

            EditCompteView(model: model)
        }
    }
}
