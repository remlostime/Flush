//
//  ContentView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

// MARK: - MainViewModel

@Observable
class MainViewModel {
    var cards: [Card?] = [nil, nil]

    var firstCard: Card? {
        cards[0]
    }

    var secondCard: Card? {
        cards[1]
    }

    var winRate: Double {
        guard let firstCard = firstCard, let secondCard = secondCard else {
            return 0.0
        }

        return Double(firstCard.number + secondCard.number + firstCard.kind.rawValue + secondCard.kind.rawValue)
    }

    var winRatePercent: String {
        let rate = Int(winRate * 100.0)
        return "\(rate)%"
    }

    func didTapCard(_ cardIndex: Int) {
        guard let card = cards[cardIndex] else {
            return
        }

        let newCard = Card(kind: card.kind.next, number: card.number)
        cards[cardIndex] = newCard
    }

    func didTapPlaceholderView(placeholderIndex: Int) {
        cards[placeholderIndex] = Card.initialCard
    }
}

// MARK: - ContentView

struct ContentView: View {
    let viewModel = MainViewModel()

    var body: some View {
        VStack {
            HStack {
                if let card = viewModel.firstCard {
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.didTapCard(0)
                        }
                } else {
                    PlaceholderView()
                        .onTapGesture {
                            viewModel.didTapPlaceholderView(placeholderIndex: 0)
                        }
                }

                if let card = viewModel.secondCard {
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.didTapCard(1)
                        }
                } else {
                    PlaceholderView()
                        .onTapGesture {
                            viewModel.didTapPlaceholderView(placeholderIndex: 1)
                        }
                }
            }

            Spacer()
                .frame(maxHeight: 32)

            Text(viewModel.winRatePercent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
