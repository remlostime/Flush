//
//  CardView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

enum Kind {
    case spade // 􀊾
    case heart // 􀊼
    case diamond // 􀊿
    case club // 􀊽

    var imageName: String {
        switch self {
        case .spade:
            return "suit.spade.fill"
        case .heart:
            return "suit.heart.fill"
        case .diamond:
            return "suit.diamond.fill"
        case .club:
            return "suit.club.fill"
        }
    }

    var color: Color {
        switch self {
        case .spade, .club:
            return .primary
        case .heart, .diamond:
            return .red
        }
    }
}

extension Int {
    var cardNumber: String {
        switch self {
        case 1:
            return "A"
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        default:
            return String(self)
        }
    }
}

struct Card {
    let kind: Kind
    let number: Int

    init(kind: Kind, number: Int) {
        self.kind = kind

        // number must be in 1...13
        let validCardNumber = max(min(13, number), 1)
        self.number = validCardNumber
    }
}

extension Card {
    static let heartA = Card(kind: .heart, number: 1)
    static let spadeK = Card(kind: .spade, number: 13)
    static let dimond3 = Card(kind: .diamond, number: 3)
    static let clubQ = Card(kind: .club, number: 12)
}

struct CardView: View {
    let card: Card

    var body: some View {
        VStack {
            Text(card.number.cardNumber)
            Image(systemName: card.kind.imageName)
        }
        .foregroundStyle(card.kind.color)
    }

    init(card: Card) {
        self.card = card
    }
}

#Preview("Heart-A") {
    CardView(card: .heartA)
}

#Preview("Spade-K") {
    CardView(card: .spadeK)
}

#Preview("Dimond-3") {
    CardView(card: .dimond3)
}

#Preview("Club-Q") {
    CardView(card: .clubQ)
}
