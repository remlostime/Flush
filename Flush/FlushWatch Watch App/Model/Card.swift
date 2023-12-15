//
//  Card.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation
import SwiftUI

// MARK: - Kind

enum Kind: Int, CaseIterable {
    case heart // 􀊼
    case spade // 􀊾
    case diamond // 􀊿
    case club // 􀊽

    // MARK: Internal

    static var random: Kind {
        let value = Int.random(in: 0 ..< Kind.allCases.count)
        return Kind(rawValue: value) ?? .heart
    }

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

    var next: Kind {
        let index = rawValue
        let allCases = Kind.allCases
        let nextIndex = (index + 1) % allCases.count

        return allCases[nextIndex]
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

// MARK: - Card

struct Card: Equatable, Hashable {
    // MARK: Lifecycle

    init(kind: Kind, number: Int) {
        self.kind = kind

        // number must be in 1...13
        let validCardNumber = max(min(13, number), 1)
        self.number = validCardNumber
    }

    // MARK: Internal

    static var random: Card {
        let kind = Kind.random
        let number = Int.random(in: 1 ... 13)

        return Card(kind: kind, number: number)
    }

    let kind: Kind
    let number: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(kind)
        hasher.combine(number)
    }
}

extension Card {
    static let heartA = Card(kind: .heart, number: 1)
    static let spadeK = Card(kind: .spade, number: 13)
    static let dimond3 = Card(kind: .diamond, number: 3)
    static let clubQ = Card(kind: .club, number: 12)
    static let initialCard = heartA
}
