//
//  CardView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

// MARK: - Kind

enum Kind: Int, CaseIterable {
  case heart // 􀊼
  case spade // 􀊾
  case diamond // 􀊿
  case club // 􀊽

  // MARK: Internal

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

struct Card: Equatable {
  // MARK: Lifecycle

  init(kind: Kind, number: Int) {
    self.kind = kind

    // number must be in 1...13
    let validCardNumber = max(min(13, number), 1)
    self.number = validCardNumber
  }

  // MARK: Internal

  let kind: Kind
  let number: Int
}

extension Card {
  static let heartA = Card(kind: .heart, number: 1)
  static let spadeK = Card(kind: .spade, number: 13)
  static let dimond3 = Card(kind: .diamond, number: 3)
  static let clubQ = Card(kind: .club, number: 12)
  static let initialCard = heartA
}

// MARK: - CardView

struct CardView: View {
  // MARK: Lifecycle

  init(card: Card) {
    self.card = card
  }

  // MARK: Internal

  let card: Card

  var body: some View {
    ZStack {
      VStack {
        Text(card.number.cardNumber)
        Image(systemName: card.kind.imageName)
      }
      .foregroundStyle(card.kind.color)

      RoundedRectangle(cornerSize: CGSize(width: 5, height: 5),
                       style: .circular)
        .strokeBorder(.primary, lineWidth: 1)
    }
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
