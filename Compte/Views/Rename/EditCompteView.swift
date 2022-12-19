//
//  EditCompteView.swift
//  Compte
//
//  Created by likeadeveloper on 19/12/22.
//

import SwiftUI

struct EditCompteView: View {
    @State var model: String
    var onCancel: (() -> Void)?
    var onSubmit: ((String) -> Void)?

    var body: some View {
        withAnimation(.easeInOut) {
            VStack {
                VStack(alignment: .center) {
                    TextField("Title",
                              text: $model)
                    .fontDesign(.monospaced)
                    .font(.title)
                    .lineLimit(0, reservesSpace: true)
                    .padding()
                    Spacer()
                    HStack(alignment: .center) {
                        Button {
                            onCancel?()
                        } label: {
                            Text("Cancel")
                        }
                        .tint(.gray)
                        .buttonStyle(.bordered)

                        Button {
                            onSubmit?(model)
                        } label: {
                            Text("Submit")
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                    }
                    .padding()
                }
                .padding()
                .background(.white)
                .frame(maxHeight: 300)
                .cornerRadius(20)
            }
            .padding()
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center)
            .background(VisualEffectView(style: .systemThinMaterial))
            .ignoresSafeArea()
        }
    }
}

struct EditCompteView_Previews: PreviewProvider {
    static var previews: some View {
        let model = "Compte for testing purposes"
        ZStack {
            Image(systemName: "square.and.arrow.up")
                .scaledToFill()
                .tint(.blue)
                .background(.red)
            EditCompteView(model: model)
        }
    }
}
