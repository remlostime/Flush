//
//  CompareCards.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/17/23.
//

import Foundation
import FlushModel

// MARK: - CompareResult

enum CompareResult {
    case win
    case lose
    case tie
}

// MARK: - CompareCards

protocol CompareCards {
    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult
}

// MARK: - RoyalFlushComparer

class RoyalFlushComparer: CompareCards {
    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        .tie
    }
}

// MARK: - StraightFlushComparer

class StraightFlushComparer: CompareCards {
    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        let sortedMyCards = myCards.sorted()
        let sortedOtherCards = otherCards.sorted()
        if let last1 = sortedMyCards.last, let last2 = sortedOtherCards.last {
            if last1 == last2 {
                return .tie
            } else if last1 < last2 {
                return .lose
            } else {
                return .win
            }
        }

        return .tie
    }
}

// MARK: - FourKindComparer

class FourKindComparer: CompareCards {
    // MARK: Internal

    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        guard let number1 = findNumber(cards: myCards), let number2 = findNumber(cards: otherCards) else {
            return .tie
        }

        if number1 < number2 {
            return .lose
        } else if number1 > number2 {
            return .win
        }

        let leftCards1 = myCards.filter { $0.number != number1 }
        let leftCards2 = otherCards.filter { $0.number != number2 }

        guard let leftNumber1 = leftCards1.first?.number, let leftNumber2 = leftCards2.first?.number else {
            return .tie
        }

        if leftNumber1 == leftNumber2 {
            return .tie
        } else if leftNumber1 < leftNumber2 {
            return .lose
        } else {
            return .win
        }
    }

    // MARK: Private

    private func findNumber(cards: [Card]) -> Number? {
        var numberCount: [Number: Int] = [:]
        for card in cards {
            let count = numberCount[card.number] ?? 0
            numberCount[card.number] = count + 1
        }

        for (key, val) in numberCount {
            if val == 4 {
                return key
            }
        }

        return nil
    }
}

// MARK: - FullHouseComparer

class FullHouseComparer: CompareCards {
    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        .tie
    }
}

// MARK: - FlushComparer

class FlushComparer: CompareCards {
    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        let sortedMyCards = myCards.sorted(by: >)
        let sortedOtherCards = otherCards.sorted(by: >)

        for i in 0 ..< sortedMyCards.count {
            let myCard = sortedMyCards[i]
            let otherCard = sortedOtherCards[i]
            if myCard.number == otherCard.number {
                continue
            } else if myCard < otherCard {
                return .lose
            } else {
                return .win
            }
        }

        return .tie
    }
}

// MARK: - StraightComparer

class StraightComparer: CompareCards {
    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        // TODO(kai) - Test case A 2 3 4 5, and 10 J Q K A
        let sortedMyCards = myCards.sorted()
        let sortedOtherCards = otherCards.sorted()
        if let last1 = sortedMyCards.last, let last2 = sortedOtherCards.last {
            if last1 == last2 {
                return .tie
            } else if last1 < last2 {
                return .lose
            } else {
                return .win
            }
        }

        return .tie
    }
}

// MARK: - ThreeKindComparer

class ThreeKindComparer: CompareCards {
    // MARK: Internal

    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        guard let number1 = findNumber(cards: myCards), let number2 = findNumber(cards: otherCards) else {
            return .tie
        }

        if number1 < number2 {
            return .lose
        } else if number1 > number2 {
            return .win
        }

        let leftCards1 = myCards.filter { $0.number != number1 }.sorted(by: >)
        let leftCards2 = otherCards.filter { $0.number != number2 }.sorted(by: >)

        for i in 0 ..< leftCards1.count {
            let myCard = leftCards1[i]
            let otherCard = leftCards2[i]
            if myCard.number == otherCard.number {
                continue
            } else if myCard < otherCard {
                return .lose
            } else {
                return .win
            }
        }

        return .tie
    }

    // MARK: Private

    private func findNumber(cards: [Card]) -> Number? {
        var numberCount: [Number: Int] = [:]
        for card in cards {
            let count = numberCount[card.number] ?? 0
            numberCount[card.number] = count + 1
        }

        for (key, val) in numberCount {
            if val >= 3 {
                return key
            }
        }

        return nil
    }
}

// MARK: - TwoPairsComparer

class TwoPairsComparer: CompareCards {
    // MARK: Internal

    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        let myNumbersCount = numbersCount(cards: myCards)
        let otherNumbersCount = numbersCount(cards: otherCards)

        let result = compare(myNumbersCount, to: otherNumbersCount, count: 2)

        switch result {
            case .lose:
                return .lose
            case .win:
                return .win
            case .tie:
                return compare(myNumbersCount, to: otherNumbersCount, count: 1)
        }
    }

    // MARK: Private

    private func numbersCount(cards: [Card]) -> [Number: Int] {
        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        return numbersCount
    }

    private func compare(_ myNumbersCount: [Number: Int], to otherNumbersCount: [Number: Int], count: Int) -> CompareResult {
        for number in Number.allCases.sorted(by: >) {
            let myCount = myNumbersCount[number] ?? 0
            let otherCount = otherNumbersCount[number] ?? 0

            if myCount >= count && otherCount >= count {
                continue
            }

            if myCount >= count {
                return .win
            }

            if otherCount >= count {
                return .lose
            }
        }

        return .tie
    }
}

// MARK: - PairComparer

class PairComparer: CompareCards {
    // MARK: Internal

    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        let myNumbersCount = numbersCount(cards: myCards)
        let otherNumbersCount = numbersCount(cards: otherCards)

        let result = compare(myNumbersCount, to: otherNumbersCount, count: 2)

        switch result {
            case .lose:
                return .lose
            case .win:
                return .win
            case .tie:
                return compare(myNumbersCount, to: otherNumbersCount, count: 1)
        }
    }

    // MARK: Private

    private func numbersCount(cards: [Card]) -> [Number: Int] {
        var numbersCount: [Number: Int] = [:]
        for card in cards {
            let count = numbersCount[card.number] ?? 0
            numbersCount[card.number] = count + 1
        }

        return numbersCount
    }

    private func compare(_ myNumbersCount: [Number: Int], to otherNumbersCount: [Number: Int], count: Int) -> CompareResult {
        for number in Number.allCases.sorted(by: >) {
            let myCount = myNumbersCount[number] ?? 0
            let otherCount = otherNumbersCount[number] ?? 0

            if myCount >= count && otherCount >= count {
                continue
            }

            if myCount >= count {
                return .win
            }

            if otherCount >= count {
                return .lose
            }
        }

        return .tie
    }
}

// MARK: - HighCardComparer

class HighCardComparer: CompareCards {
    func compare(myCards: [Card], to otherCards: [Card]) -> CompareResult {
        let sortedMyCards = myCards.sorted(by: >)
        let sortedOtherCards = otherCards.sorted(by: >)

        for i in 0 ..< sortedMyCards.count {
            let last1 = sortedMyCards[i]
            let last2 = sortedOtherCards[i]
            if last1 == last2 {
                return .tie
            } else if last1 < last2 {
                return .lose
            } else {
                return .win
            }
        }

        return .tie
    }
}
