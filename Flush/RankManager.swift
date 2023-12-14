//
//  RankManager.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import Foundation

// MARK: - RankRateCalculator

protocol RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double
}

// MARK: - RoyalFlushRater

class RoyalFlushRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - StraightFlushRater

class StraightFlushRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - FourKindRater

class FourKindRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - FullHouseRater

class FullHouseRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - FlushRater

class FlushRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - StraightRater

class StraightRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - ThreeKindRater

class ThreeKindRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - TwoPairsRater

class TwoPairsRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - PairRater

class PairRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

// MARK: - HighCardRater

class HighCardRater: RankRateCalculator {
    func calculateRate(privateCards: [Card?], publicCards: [Card?]) -> Double {
        Double.random(in: 0 ... 1)
    }
}

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
    func calculateRankRate() -> [RankRate]
}

// MARK: - DefaultRankManager

class DefaultRankManager: RankManager {
    // MARK: Lifecycle

    init(privateCards: [Card?], publicCards: [Card?]) {
        self.privateCards = privateCards
        self.publicCards = publicCards
    }

    // MARK: Internal

    func rankRateCalculator(for rank: Rank) -> RankRateCalculator {
        switch rank {
            case .royalFlush:
                return RoyalFlushRater()
            case .straightFlush:
                return StraightRater()
            case .fourKind:
                return FourKindRater()
            case .fullHouse:
                return FullHouseRater()
            case .flush:
                return FlushRater()
            case .straight:
                return StraightRater()
            case .threeKind:
                return ThreeKindRater()
            case .twoPairs:
                return TwoPairsRater()
            case .pair:
                return PairRater()
            case .highCard:
                return HighCardRater()
        }
    }

    func calculateRankRate() -> [RankRate] {
        let ranks = Rank.allCases
        let rankRate = ranks.map { rank in
            let rater = rankRateCalculator(for: rank)
            let rate = rater.calculateRate(privateCards: privateCards, publicCards: publicCards)

            return RankRate(rank: rank, rate: rate)
        }

        return rankRate
    }

    // MARK: Private

    private let privateCards: [Card?]
    private let publicCards: [Card?]
}
