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
                return ListCard(card: card, id: UUID())
            } else {
                return nil
            }
        }

        let privateCards: [ListCard?] = board.privateCards.map { card in
            if let card = card {
                return ListCard(card: card, id: UUID())
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

    var isResultViewPresented: Bool = false
    var isSelectedCardViewPresented: Bool = false

    var playersNumber: Int
    var privateListCards: [ListCard?]
    var publicListCards: [ListCard?]

    var currentSelectedCard: ListCard = .initial {
        didSet {
            switch cardType {
                case .public:
                    publicListCards[cardIndex] = currentSelectedCard
                case .private:
                    privateListCards[cardIndex] = currentSelectedCard
            }
        }
    }

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

    func didTapCard(_ cardIndex: Int, cardType: CardType) {
        self.cardType = cardType
        self.cardIndex = cardIndex

        switch cardType {
            case .private:
                didTapCard(cardIndex, cards: &privateListCards)
            case .public:
                didTapCard(cardIndex, cards: &publicListCards)
        }
    }

    func reset() {
        privateListCards = privateListCards.map { _ in nil }
        publicListCards = publicListCards.map { _ in nil }
    }

    // MARK: Private

    private var cardType: CardType = .private
    private var cardIndex: Int = 0

    private func didTapCard(_ cardIndex: Int, cards: inout [ListCard?]) {
        let listCard = cards[cardIndex] ?? ListCard.initial
        cards[cardIndex] = listCard

        currentSelectedCard = listCard
        isSelectedCardViewPresented = true
    }
}
