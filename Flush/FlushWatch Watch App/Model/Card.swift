//
//  Card.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation
import SwiftUI

// MARK: - Number

enum Number: Int, CustomStringConvertible, CaseIterable, Equatable, Comparable {
    case ace = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king

    // MARK: Internal

    static var random: Number {
        let val = Int.random(in: 1 ... Number.allCases.count)
        let number = Number(rawValue: val) ?? .ace
        return number
    }

    var imageName: String {
        switch self {
        case .ace:
            return "a.circle"
        case .two:
            return "2.circle"
        case .three:
            return "3.circle"
        case .four:
            return "4.circle"
        case .five:
            return "5.circle"
        case .six:
            return "6.circle"
        case .seven:
            return "7.circle"
        case .eight:
            return "8.circle"
        case .nine:
            return "9.circle"
        case .ten:
            return "10.circle"
        case .jack:
            return "j.circle"
        case .queen:
            return "q.circle"
        case .king:
            return "k.circle"
        }
    }

    var description: String {
        switch self {
            case .ace:
                return "A"
            case .two:
                return "2"
            case .three:
                return "3"
            case .four:
                return "4"
            case .five:
                return "5"
            case .six:
                return "6"
            case .seven:
                return "7"
            case .eight:
                return "8"
            case .nine:
                return "9"
            case .ten:
                return "10"
            case .jack:
                return "J"
            case .queen:
                return "Q"
            case .king:
                return "K"
        }
    }

    var cardNumber: String {
        description
    }

    var next: Number {
        if self == .king {
            return .ace
        }

        return Number(rawValue: rawValue + 1) ?? .ace
    }

    static func < (lhs: Number, rhs: Number) -> Bool {
        if lhs == .ace {
            return false
        }

        if rhs == .ace {
            return true
        }

        return lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Kind

enum Kind: Int, CaseIterable, Identifiable {
    case heart // 􀊼
    case spade // 􀊾
    case diamond // 􀊿
    case club // 􀊽

    // MARK: Internal

    static var random: Kind {
        let value = Int.random(in: 0 ..< Kind.allCases.count)
        return Kind(rawValue: value) ?? .heart
    }

    var id: Int {
        rawValue
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

// MARK: - Card

struct Card: Equatable, Hashable, Comparable {
    // MARK: Lifecycle

    init(kind: Kind, number: Number) {
        self.kind = kind
        self.number = number
    }

    init(kind: Kind, number: Int) {
        self.kind = kind
        self.number = Number(rawValue: number) ?? .ace
    }

    // MARK: Internal

    static let PrivateCardsTotalNumber = 2
    static let PublicCardsTotalNumber = 5
    static let HandCardsNumber = 5

    static var random: Card {
        Card(kind: Kind.random, number: Number.random)
    }

    static var AllCardsTotalNumber: Int {
        PrivateCardsTotalNumber + PublicCardsTotalNumber
    }

    let kind: Kind
    let number: Number

    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.number < rhs.number
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(kind)
        hasher.combine(number)
    }
}

extension Card {
    static let heartA = Card(kind: .heart, number: .ace)
    static let spadeK = Card(kind: .spade, number: .king)
    static let dimond3 = Card(kind: .diamond, number: .three)
    static let clubQ = Card(kind: .club, number: .queen)
    static let initialCard = heartA
}
