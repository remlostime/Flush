//
//  RankManager.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// MARK: - RankRate

struct RankRate: Identifiable {
    let rank: Rank
    let rate: Double

    var id: Rank {
        rank
    }
}

// MARK: - RankManager

protocol RankManager {
    func calculateRankRate(privateCards: [Card?], publicCards: [Card?]) -> [RankRate]
}

// MARK: - DefaultRankManager

class DefaultRankManager: RankManager {
    // MARK: Internal

    func rankChecker(for rank: Rank) -> RankChecker {
        switch rank {
            case .royalFlush:
                return RoyalFlushChecker()
            case .straightFlush:
                return StraightChecker()
            case .fourKind:
                return FourKindChecker()
            case .fullHouse:
                return FullHouseChecker()
            case .flush:
                return FlushChecker()
            case .straight:
                return StraightChecker()
            case .threeKind:
                return ThreeKindChecker()
            case .twoPairs:
                return TwoPairsChecker()
            case .pair:
                return PairChecker()
            case .highCard:
                return HighCardChecker()
        }
    }

    func calculateRankRate(privateCards: [Card?], publicCards: [Card?]) -> [RankRate] {
        let ranks = Rank.allCases
        var rankRateCount: [Rank: Int] = [:]

        for rank in ranks {
            rankRateCount[rank] = 0
        }

        for _ in 0 ..< simulateTimes {
            let (privateCards, publicCards) = simulatePossibleCards(privateCards: privateCards, publicCards: publicCards)

            for rank in ranks {
                let rankChecker = rankChecker(for: rank)
                let isValidCount = rankChecker.isValid(privateCards: privateCards, publicCards: publicCards) ? 1 : 0
                let count = rankRateCount[rank] ?? 0
                rankRateCount[rank] = count + isValidCount
            }
        }

        let rankRate = rankRateCount.map { rank, val in
            let rate = Double(val) / Double(simulateTimes)

            return RankRate(rank: rank, rate: rate)
        }

        return rankRate
    }

    // MARK: Private

    private let simulateTimes = 10000

    private func simulatePossibleCards(privateCards: [Card?], publicCards: [Card?]) -> (privateCards: [Card], publicCards: [Card]) {
        var cards = (privateCards + publicCards).compactMap { $0 }
        let needCardsNumber = 5 - cards.count

        var simulatedPrivateCards = privateCards.compactMap { $0 }
        var simulatedPublicCards = publicCards.compactMap { $0 }

        for _ in 0 ..< needCardsNumber {
            var card = Card.random
            while cards.contains(card) {
                card = Card.random
            }
            cards.append(card)

            if simulatedPrivateCards.count < 2 {
                simulatedPrivateCards.append(card)
            } else if simulatedPublicCards.count < 3 {
                simulatedPublicCards.append(card)
            }
        }

        return (privateCards: simulatedPrivateCards, publicCards: simulatedPublicCards)
    }
}
