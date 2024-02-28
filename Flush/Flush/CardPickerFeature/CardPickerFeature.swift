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
    @ObservableState
    struct State: Equatable {
        var card: Card
        
        init(card: Card) {
            self.card = card
        }
    }
    
    enum Action {
        case selectCard(Card)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .selectCard(let card):
                print(card)
                return .none
            }
        }
    }
}
