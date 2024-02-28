//
//  ContentView.swift
//  Flush
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct MainScreenFeature {
    struct SelectedCard: Equatable {
        let card: Card
        let type: CardType
        let index: Int
    }
    
    @ObservableState
    struct State: Equatable {
        var board: Board
        var currentSelectedCard: SelectedCard?
        
        init(board: Board) {
            self.board = board
            self.currentSelectedCard = nil
        }
    }
    
    enum Action {
        case tapCard(Card?, metadata: (cardType: CardType, index: Int))
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapCard(let card, let metadata):
                state.currentSelectedCard = .init(card: card ?? .initialCard, type: metadata.cardType, index: metadata.index)
                return .none
            }
        }
    }
}

struct ContentView: View {
    let store: StoreOf<MainScreenFeature>
    
    // TODO(Kai) - update to the TCA way
    // case presentCardPickerView(PresentationAction<CardPickerFeature.Action>)
    // .sheet(item:)
    @State var isCardPickerSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0..<store.board.publicCards.count, id:\.self) { index in
                    if let card = store.board.publicCards[index] {
                        CardView(card: card)
                            .onTapGesture {
                                store.send(.tapCard(card, metadata: (cardType: .public, index: index)))
                                isCardPickerSheetPresented.toggle()
                            }
                    } else {
                        PlaceholderView(iconSize: 32.0)
                            .onTapGesture {
                                store.send(.tapCard(nil, metadata: (cardType: .public, index: index)))
                                isCardPickerSheetPresented.toggle()
                            }
                    }
                    
                }
            }
            
            HStack {
                ForEach(0..<store.board.privateCards.count, id:\.self) { index in
                    if let card = store.board.privateCards[index] {
                        CardView(card: card)
                            .onTapGesture {
                                store.send(.tapCard(card, metadata: (cardType: .private, index: index)))
                                isCardPickerSheetPresented.toggle()
                            }
                    } else {
                        PlaceholderView(iconSize: 32.0)
                            .onTapGesture {
                                store.send(.tapCard(nil, metadata: (cardType: .private, index: index)))
                                isCardPickerSheetPresented.toggle()
                            }
                    }
                }
            }
        }
        .sheet(isPresented: $isCardPickerSheetPresented) {
            CardPickerView()
        }
    }
}

#Preview {
    ContentView(store: .init(initialState: MainScreenFeature.State(board: .init(privateCards: [nil, nil], publicCards: [nil, nil, nil, nil, nil], playersNumber: 1)), reducer: {
        MainScreenFeature()
    }))
}
