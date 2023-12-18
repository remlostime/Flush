//
//  CardsPickerView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

struct CardsPickerView: View {
    // MARK: Lifecycle

    init(board: Binding<Board>) {
        _board = board
        viewModel = CardsPickerViewModel(board: board.wrappedValue)
    }

    // MARK: Internal

    @Bindable var viewModel: CardsPickerViewModel
    @Binding var board: Board

    var body: some View {
        NavigationStack {
            VStack {
                PlayersNumberView(number: viewModel.playersNumber)
                    .focusable()
                    .digitalCrownRotation($viewModel.playersNumberDigitalCrown,
                                          from: Double(Board.MinPlayerNumber),
                                          through: Double(Board.MaxPlayerNumber),
                                          by: 1,
                                          sensitivity: .medium)

                HStack {
                    if let card = viewModel.privateCards[0] {
                        CardView(card: card, isSelected: false)
                    } else {
                        PlaceholderView(isSelected: false)
                    }

                    if let card = viewModel.privateCards[1] {
                        CardView(card: card, isSelected: false)
                    } else {
                        PlaceholderView(isSelected: false)
                    }
                }

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0 ..< viewModel.publicListCards.count, id: \.self) { index in
                            if let publicCard = viewModel.publicListCards[index] {
                                CardView(card: publicCard.card, isSelected: publicCard.isSelected)
                                    .onTapGesture {
                                        viewModel.didTapCard(index)
                                    }
                                    .focusable()
                                    .digitalCrownRotation($viewModel.cardValues[index],
                                                          from: 1,
                                                          through: 14,
                                                          by: 1,
                                                          sensitivity: .medium)
                            } else {
                                PlaceholderView(isSelected: false, iconSize: 16.0)
                                    .onTapGesture {
                                        viewModel.didTapPlaceholderView(placeholderIndex: index)
                                    }
                            }
                        }
                    }
                }

                NavigationLink("Calculate") {
                    ResultView(board: $board)
                }
            }
        }
        .padding()
        .onDisappear {
            board = Board(privateCards: viewModel.privateCards,
                          publicCards: viewModel.publicCards,
                          playersNumber: viewModel.playersNumber)
        }
    }
}

#Preview {
    CardsPickerView(board: Binding<Board>.constant(.initial))
}
