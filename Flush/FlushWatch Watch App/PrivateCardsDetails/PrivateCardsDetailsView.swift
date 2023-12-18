//
//  PrivateCardsDetailsView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

struct PrivateCardsDetailsView: View {
    // MARK: Lifecycle

    init(board: Binding<Board>) {
        _board = board
        viewModel = PrivateCardsDetailsViewModel(cards: board.privateCards.wrappedValue,
                                                 playersNumber: board.playersNumber.wrappedValue)
    }

    // MARK: Internal

    @Bindable var viewModel: PrivateCardsDetailsViewModel
    @Binding var board: Board

    var body: some View {
        HStack {
            VStack {
                PlayersNumberView(number: viewModel.playersNumber)
                    .focusable()
                    .digitalCrownRotation($viewModel.playersNumberDigitalCrown,
                                          from: Double(Board.MinPlayerNumber),
                                          through: Double(Board.MaxPlayerNumber),
                                          by: 1,
                                          sensitivity: .low)

                HStack {
                    if let card = viewModel.firstCard {
                        CardView(card: card, isSelected: viewModel.isFirstCardSelected)
                            .onTapGesture {
                                viewModel.didTapCard(0)
                            }
                            .focusable()
                            .digitalCrownRotation($viewModel.firstCardValue,
                                                  from: 1,
                                                  through: 14,
                                                  by: 1,
                                                  sensitivity: .low,
                                                  isContinuous: true)
                    } else {
                        PlaceholderView(isSelected: viewModel.isFirstCardSelected)
                            .onTapGesture {
                                viewModel.didTapPlaceholderView(placeholderIndex: 0)
                            }
                    }

                    if let card = viewModel.secondCard {
                        CardView(card: card, isSelected: viewModel.isSecondCardSelected)
                            .onTapGesture {
                                viewModel.didTapCard(1)
                            }
                            .focusable()
                            .digitalCrownRotation($viewModel.secondCardValue,
                                                  from: 1,
                                                  through: 14,
                                                  by: 1,
                                                  sensitivity: .medium)
                    } else {
                        PlaceholderView(isSelected: viewModel.isSecondCardSelected)
                            .onTapGesture {
                                viewModel.didTapPlaceholderView(placeholderIndex: 1)
                            }
                    }
                }

                Spacer()
                    .frame(maxHeight: 32)

                Text(viewModel.winRatePercent)
            }

            List(viewModel.rankRate) { rankRate in
                RankRateView(rankRate: rankRate)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
            }
            .listStyle(.carousel)
        }
        .padding()
        .onDisappear {
            board = Board(privateCards: viewModel.cards,
                          publicCards: board.publicCards,
                          playersNumber: viewModel.playersNumber)
        }
    }
}

#Preview("initial") {
    PrivateCardsDetailsView(board: Binding<Board>.constant(.initial))
}

#Preview("Heart-A and Club-A") {
    PrivateCardsDetailsView(board: Binding<Board>.constant(.init(privateCards: [Card(kind: .club, number: 1), Card(kind: .heart, number: 1)],
                                                                 publicCards: [],
                                                                 playersNumber: 2)))
}
