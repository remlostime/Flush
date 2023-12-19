//
//  ResultViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// MARK: - ResultViewModel

@Observable
class ResultViewModel {
    // MARK: Lifecycle

    init(rankManager: RankManager = DefaultRankManager(),
         privateCards: [Card?] = [nil, nil],
         publicListCards: [ListCard?] = [nil, nil, nil, nil, nil],
         playersNumber: Int = 1)
    {
        self.rankManager = rankManager
        self.privateCards = privateCards
        self.publicListCards = publicListCards
        self.playersNumber = playersNumber
        playersNumberDouble = Double(playersNumber)
    }

    convenience init(board: Board) {
        let publicListCards: [ListCard?] = board.publicCards.map { card in
            if let card = card {
                return ListCard(card: card, id: UUID(), isSelected: false)
            } else {
                return nil
            }
        }

        self.init(privateCards: board.privateCards,
                  publicListCards: publicListCards)
    }

    // MARK: Internal

    let rankManager: RankManager

    var playersNumber: Int
    var privateCards: [Card?]
    var publicListCards: [ListCard?]

    var playersNumberDouble: Double {
        didSet {
            playersNumber = Int(playersNumberDouble)
        }
    }

    var publicCards: [Card?] {
        publicListCards.map { listCard in
            if let listCard = listCard {
                return listCard.card
            } else {
                return nil
            }
        }
    }

    var winRate: Double {
        rankManager.calculateWinRate(board: Board(privateCards: privateCards,
                                                  publicCards: publicCards,
                                                  playersNumber: playersNumber))
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)% Win"
    }

    var rankRate: [RankRate] {
        rankManager.calculateRankRate(privateCards: privateCards, publicCards: publicCards)
    }

    func resetCardSelected(forValue newValue: Bool) {
        for index in 0 ..< publicListCards.count {
            publicListCards[index]?.isSelected = newValue
        }
    }

    func didTapCard(_ cardIndex: Int) {
        guard var publicCard = publicListCards[cardIndex] else {
            return
        }

        let card = publicCard.card

        // if `selected` then we update the `kind`
        if publicCard.isSelected {
            let newCard = Card(kind: card.kind.next, number: card.number)
            publicListCards[cardIndex] = ListCard(card: newCard,
                                                  id: publicCard.id,
                                                  isSelected: publicCard.isSelected)
        } else {
            resetCardSelected(forValue: false)
            publicCard.isSelected = true
            publicListCards[cardIndex] = publicCard
        }
    }

    func didTapPlaceholderView(placeholderIndex: Int) {
        publicListCards[placeholderIndex] = ListCard.initial
        resetCardSelected(forValue: false)
        publicListCards[placeholderIndex]?.isSelected = true
    }
}

extension ResultViewModel {
    static let empty = ResultViewModel()
}
