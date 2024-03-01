//
//  MainSreenView.swift
//  Flush
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI
import ComposableArchitecture

struct MainScreenView: View {
    let store: StoreOf<MainScreenFeature>
    
    // TODO(Kai) - update to the TCA way
    // case presentCardPickerView(PresentationAction<CardPickerFeature.Action>)
    // .sheet(item:)
    @State var isCardPickerSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Public Cards")
                .font(.title)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
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
            
            
            Text("Private Cards")
                .font(.title)
                .foregroundColor(.secondary)
                .padding(.bottom, 4)
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
                
                VStack {
                    Text("Win Rate")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 4)
                    Text(store.winRateFormated)
                }
            }
        }
        .sheet(isPresented: $isCardPickerSheetPresented) {
            CardPickerView(store: .init(initialState: CardPickerFeature.State(card: store.currentSelectedCard.card), reducer: {
                CardPickerFeature {
                    store.send(.selectCard($0))
                }
            }))
        }
    }
}

#Preview {
    MainScreenView(store: .init(initialState: MainScreenFeature.State(board: .init(privateCards: [nil, nil], publicCards: [nil, nil, nil, nil, nil], playersNumber: 1)), reducer: {
        MainScreenFeature(environment: .init(rankService: DefaultRankManager()))
    }))
}
