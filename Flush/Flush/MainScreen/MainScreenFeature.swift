//
//  MainSreenFeature.swift
//  Flush
//
//  Created by Kai Chen on 2/29/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainScreenFeature {
    struct Environment {
        let rankService: RankManager
    }
    
    let environment: Environment
    
    struct SelectedCard: Equatable {
        let card: Card
        let type: CardType
        let index: Int
    }
    
    @ObservableState
    struct State: Equatable {
        var board: Board
        var currentSelectedCard: SelectedCard
        var winRate: Double
        var winRateFormated: String {
            String(format: "%.2f", winRate * 100) + "%"
        }
        
        init(board: Board) {
            self.board = board
            self.currentSelectedCard = .init(card: .initialCard, type: .public, index: 0)
            self.winRate = 0
        }
    }
    
    enum Action {
        case tapCard(Card?, metadata: (cardType: CardType, index: Int))
        case selectCard(Card)
        case calculateWinRate
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .tapCard(let card, let metadata):
                state.currentSelectedCard = .init(card: card ?? .initialCard, type: metadata.cardType, index: metadata.index)
                return .none
            case .selectCard(let card):
                switch state.currentSelectedCard.type {
                case .public:
                    state.board.publicCards[state.currentSelectedCard.index] = card
                case .private:
                    state.board.privateCards[state.currentSelectedCard.index] = card
                }
                return Effect.send(.calculateWinRate)
            case .calculateWinRate:
                state.winRate = environment.rankService.calculateWinRate(board: state.board)
                return .none
            }
        }
    }
}
