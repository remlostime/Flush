//
//  CardPickerView.swift
//  Flush
//
//  Created by Kai Chen on 2/27/24.
//

import SwiftUI
import ComposableArchitecture

struct CardPickerView: View {
    let store: StoreOf<CardPickerFeature>
    
    public var body: some View {
        VStack {
            HStack {
                ForEach(Kind.allCases, id: \.self) { kind in
                    Button(action: {
                        store.send(.selectCard(.init(kind: kind, number: store.card.number)))
                    }, label: {
                        Image(systemName: kind.imageName)
                            .foregroundStyle(kind.color)
                            .imageScale(.large)
                    })
                    .buttonStyle(.borderless)
                }
            }

            CardView(card: store.card)
                .frame(height: 200)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(Number.allCases, id: \.self) { number in
                        Button(action: {
                            store.send(.selectCard(.init(kind: store.card.kind, number: number)))
                        }, label: {
                            Image(systemName: number.imageName)
                                .imageScale(.large)
                        })
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
        .onDisappear(perform: {
            store.send(.dismiss)
        })
    }
}

#Preview {
    CardPickerView(store: .init(initialState: CardPickerFeature.State(card: .initialCard), reducer: {
        CardPickerFeature { _ in }
    }))
}
