//
//  Rank.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// MARK: - Rank

enum Rank: Int, CustomStringConvertible, Identifiable, CaseIterable {
    case royalFlush
    case straightFlush
    case fourKind
    case fullHouse
    case flush
    case straight
    case threeKind
    case twoPairs
    case pair
    case highCard

    // MARK: Internal

    var id: Int {
        rawValue
    }

    var description: String {
        switch self {
            case .royalFlush:
                return "Royal Flush"
            case .straightFlush:
                return "Straight Flush"
            case .fourKind:
                return "Four of a Kind"
            case .fullHouse:
                return "Full House"
            case .flush:
                return "Flush"
            case .straight:
                return "Straight"
            case .threeKind:
                return "Three of a Kind"
            case .twoPairs:
                return "Two Pairs"
            case .pair:
                return "Pair"
            case .highCard:
                return "High Card"
        }
    }
}
