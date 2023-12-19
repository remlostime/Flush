//
//  CardsPickerViewModel.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

@Observable
class CardsPickerViewModel {
    // MARK: Lifecycle

    init(privateCards: [ListCard?] = [nil, nil],
         publicCards: [ListCard?] = [nil, nil, nil, nil, nil],
         playersNumber: Int = 2)
    {
        privateListCards = privateCards
        publicListCards = publicCards
        playersNumberDigitalCrown = Double(playersNumber)
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

        let privateCards: [ListCard?] = board.privateCards.map { card in
            if let card = card {
                return ListCard(card: card, id: UUID(), isSelected: false)
            } else {
                return nil
            }
        }

        self.init(privateCards: privateCards,
                  publicCards: publicCards,
                  playersNumber: board.playersNumber)
    }

    // MARK: Internal

    enum CardType {
        case `public`
        case `private`
    }

    var playersNumber: Int
    var privateListCards: [ListCard?]
    var publicListCards: [ListCard?]

    var playersNumberDigitalCrown: Double {
        didSet {
            playersNumber = Int(playersNumberDigitalCrown)
        }
    }

    var privateCards: [Card?] {
        privateListCards.map { listCard in
            if let listCard = listCard {
                return listCard.card
            } else {
                return nil
            }
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

    var privateCardValues: [Double] = [1, 1] {
        didSet {
            privateListCards = privateListCards.map { listCard in
                guard let listCard = listCard,
                      let index = privateListCards.firstIndex(of: listCard)
                else {
                    return nil
                }

                let card = Card(kind: listCard.card.kind, number: Int(privateCardValues[index]))
                return ListCard(card: card, id: listCard.id, isSelected: listCard.isSelected)
            }
        }
    }

    var publicCardValues: [Double] = [1, 1, 1, 1, 1] {
        didSet {
            publicListCards = publicListCards.map { listCard in
                guard let listCard = listCard,
                      let index = publicListCards.firstIndex(of: listCard)
                else {
                    return nil
                }

                let card = Card(kind: listCard.card.kind, number: Int(publicCardValues[index]))
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
        publicListCards = publicListCards.map { listCard in
            guard let listCard else {
                return nil
            }

            return ListCard(card: listCard.card, id: UUID(), isSelected: newValue)
        }

        privateListCards = privateListCards.map { listCard in
            guard let listCard else {
                return nil
            }

            return ListCard(card: listCard.card, id: UUID(), isSelected: newValue)
        }
    }

    func didTapCard(_ cardIndex: Int, cardType: CardType) {
        switch cardType {
            case .private:
                didTapCard(cardIndex, cards: &privateListCards)
            case .public:
                didTapCard(cardIndex, cards: &publicListCards)
        }
    }

    func didTapPlaceholderView(placeholderIndex: Int, type: CardType) {
        switch type {
            case .private:
                didTapPlaceholderView(index: placeholderIndex, cards: &privateListCards)
            case .public:
                didTapPlaceholderView(index: placeholderIndex, cards: &publicListCards)
        }
    }

    // MARK: Private

    private func didTapCard(_ cardIndex: Int, cards: inout [ListCard?]) {
        guard let listCard = cards[cardIndex] else {
            return
        }

        let card = listCard.card

        // if `selected` then we update the `kind`
        if listCard.isSelected {
            resetCardSelected(forValue: false)
            let newCard = Card(kind: card.kind.next, number: card.number)
            cards[cardIndex] = ListCard(card: newCard,
                                        id: listCard.id,
                                        isSelected: true)
        } else {
            resetCardSelected(forValue: false)
            let updatedListCard = ListCard(card: listCard.card, id: listCard.id, isSelected: true)
            cards[cardIndex] = updatedListCard
        }
    }

    private func didTapPlaceholderView(index: Int, cards: inout [ListCard?]) {
        resetCardSelected(forValue: false)
        var listCard = ListCard.initial
        listCard.isSelected = true
        cards[index] = listCard
    }
}
