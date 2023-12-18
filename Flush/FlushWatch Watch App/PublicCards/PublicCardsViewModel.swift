//
//  PublicCardsViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

@Observable
class PublicCardsViewModel {
    // MARK: Lifecycle

    init(privateCards: [Card?] = [nil, nil],
         publicCards: [ListCard?] = [nil, nil, nil, nil, nil],
         playersNumber: Int = 1)
    {
        self.privateCards = privateCards
        publicListCards = publicCards
        self.playersNumberDouble = Double(playersNumber)
        self.playersNumber = playersNumber
    }

    convenience init(board: Board) {
        let publicCards: [ListCard?] = board.publicCards.map { card in
            if let card = card {
                return ListCard(card: card, id: UUID(), isSelected: false)
            } else {
                return nil
            }
        }

        self.init(privateCards: board.privateCards,
                  publicCards: publicCards)
    }

    // MARK: Internal

    var playersNumberDouble: Double {
        didSet {
            playersNumber = Int(playersNumberDouble)
        }
    }
    var playersNumber: Int
    var privateCards: [Card?]
    var publicListCards: [ListCard?]

    var publicCards: [Card?] {
        publicListCards.map { listCard in
            if let listCard = listCard {
                return listCard.card
            } else {
                return nil
            }
        }
    }

    var cardValues: [Double] = [1, 1, 1, 1, 1] {
        didSet {
            publicListCards = publicListCards.map { listCard in
                guard let listCard = listCard,
                      let index = publicListCards.firstIndex(of: listCard)
                else {
                    return nil
                }

                let card = Card(kind: listCard.card.kind, number: Int(cardValues[index]))
                return ListCard(card: card, id: listCard.id, isSelected: listCard.isSelected)
            }
        }
    }

    var winRate: Double {
        0.30
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)%"
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
