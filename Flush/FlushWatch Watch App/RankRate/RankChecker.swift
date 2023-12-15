//
//  RankChecker.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/14/23.
//

import Foundation

// MARK: - RankChecker

protocol RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool
}

// MARK: - RoyalFlushChecker

struct RoyalFlushChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        let straightFlushChecker = StraightFlushChecker()
        guard straightFlushChecker.isValid(privateCards: privateCards, publicCards: publicCards) else {
            return false
        }

        // TODO(kai) - check 10...A
        return true
    }
}

// MARK: - StraightFlushChecker

struct StraightFlushChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        let flushChecker = FlushChecker()
        guard flushChecker.isValid(privateCards: privateCards, publicCards: publicCards) else {
            return false
        }

        let straightChecker = StraightChecker()
        guard straightChecker.isValid(privateCards: privateCards, publicCards: publicCards) else {
            return false
        }

        return true
    }
}

// MARK: - FourKindChecker

struct FourKindChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        var numbersCount: [Int: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        for val in numbersCount.values {
            if val == 4 {
                return true
            }
        }

        return false
    }
}

// MARK: - FullHouseChecker

struct FullHouseChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        var numbersCount: [Int: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        guard numbersCount.values.count == 2 else {
            return false
        }

        for val in numbersCount.values {
            if val == 2 || val == 3 {
                return true
            }
        }

        return false
    }
}

// MARK: - FlushChecker

struct FlushChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        let kind = cards.first?.kind
        let isSameKind = cards.reduce(true) { partialResult, card in
            partialResult && (card.kind == kind)
        }

        return isSameKind
    }
}

// MARK: - StraightChecker

struct StraightChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        let sortedCards = cards.sorted { $0.number < $1.number }

        for index in 1 ..< sortedCards.count {
            let preCard = sortedCards[index - 1]
            let currentCard = sortedCards[index]

            if currentCard.number == preCard.number + 1 {
                continue
            } else {
                return false
            }
        }

        return true
    }
}

// MARK: - ThreeKindChecker

class ThreeKindChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        var numbersCount: [Kind: Int] = [:]
        for card in cards {
            let count = numbersCount[card.kind] ?? 0
            numbersCount[card.kind] = count + 1
        }

        for val in numbersCount.values {
            if val == 3 {
                return true
            }
        }

        return false
    }
}

// MARK: - TwoPairsChecker

struct TwoPairsChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        var numbersCount: [Kind: Int] = [:]
        for card in cards {
            let count = numbersCount[card.kind] ?? 0
            numbersCount[card.kind] = count + 1
        }

        guard numbersCount.values.count == 3 else {
            return false
        }

        for val in numbersCount.values {
            if val == 2 || val == 1 {
                continue
            } else {
                return false
            }
        }

        return true
    }
}

// MARK: - PairChecker

struct PairChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        var numbersCount: [Int: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        for val in numbersCount.values {
            if val >= 2 {
                return true
            }
        }

        return false
    }
}

// MARK: - HighCardChecker

// High cards is defined as J, Q, K, A
struct HighCardChecker: RankChecker {
    func isValid(privateCards: [Card], publicCards: [Card]) -> Bool {
        let cards = privateCards + publicCards
        guard cards.count == 5 else {
            return false
        }

        let highCardNumbers = Set([11, 12, 13, 1])
        for card in cards {
            if highCardNumbers.contains(card.number) {
                return true
            }
        }

        return false
    }
}
