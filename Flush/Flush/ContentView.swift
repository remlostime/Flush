//
//  ContentView.swift
//  Flush
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct CardPickerFeature {
    @ObservableState
    struct State: Equatable {
        var board: Board
        @Presents var tappedCard: Card?
        
        init(board: Board) {
            self.board = board
        }
    }
    
    enum Action {
        case tapCard(Card?, metadata: (cardType: CardType, index: Int))
        case selectCard(PresentationAction<Card>)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapCard(let card, let metadata):
                print("Card", card)
                print("metadata", metadata)
                state.tappedCard = card ?? Card.initialCard
                return .none
            }
        }
    }
}

struct ContentView: View {
    let store: StoreOf<CardPickerFeature>
    
    @State var isPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0..<store.board.publicCards.count, id:\.self) { index in
                    if let card = store.board.publicCards[index] {
                        CardView(card: card)
                            .onTapGesture {
                                store.send(.tapCard(card, metadata: (cardType: .public, index: index)))
                            }
                            // TODO(kai) - fix this
                            .sheet(item: ..., content: { _ in
                                Text("TODO - Card select view")
                            })
                    } else {
                        PlaceholderView(iconSize: 32.0)
                            .onTapGesture {
                                store.send(.tapCard(nil, metadata: (cardType: .public, index: index)))
                            }
                    }

                }
            }
            
            HStack {
                ForEach(0..<store.board.privateCards.count, id:\.self) { index in
                    if let card = store.board.privateCards[index] {
                        CardView(card: card)
                            .onTapGesture {
                                store.send(.tapCard(card))
                            }
                    } else {
                        PlaceholderView(iconSize: 32.0)
                            .onTapGesture {
                                store.send(.tapCard(nil))
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(store: .init(initialState: CardPickerFeature.State(board: .init(privateCards: [nil, nil], publicCards: [nil, nil, nil, nil, nil], playersNumber: 1)), reducer: {
        CardPickerFeature()
    }))
}
