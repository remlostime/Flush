//
//  CardPickerFeature.swift
//  Flush
//
//  Created by Kai Chen on 2/27/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CardPickerFeature {
    let onDismiss: (Card) -> Void
    
    @ObservableState
    struct State: Equatable {
        var card: Card
        
        init(card: Card) {
            self.card = card
        }
    }
    
    enum Action {
        case selectCard(Card)
        case dismiss
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .selectCard(let card):
                state.card = card
                return .none
            case .dismiss:
                onDismiss(state.card)
                return .none
            }
        }
    }
}
