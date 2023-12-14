//
//  PrivateCardsView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

// MARK: - ContentView

struct PrivateCardsView: View {
    @Bindable var viewModel: PrivateCardsViewModel

    @Binding var board: Board

    init(board: Binding<Board>) {
        _board = board
        viewModel = PrivateCardsViewModel(cards: board.privateCards.wrappedValue)
    }

    var body: some View {
        VStack {
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
                                              sensitivity: .low,
                                              isContinuous: true)
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
        .padding()
        .onDisappear {
            board = Board(privateCards: viewModel.cards, publicCards: board.publicCards)
        }
    }
}

#Preview {
    PrivateCardsView(board: Binding<Board>.constant(.initial))
}
