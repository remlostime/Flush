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
        VStack(alignment: .leading) {
            HStack {
                Text("Players")
                    .font(.footnote)
                PlayersNumberView(number: viewModel.playersNumber)
                    .focusable()
                    .digitalCrownRotation($viewModel.playersNumberDigitalCrown,
                                          from: Double(Board.MinPlayerNumber),
                                          through: Double(Board.MaxPlayerNumber),
                                          by: 1,
                                          sensitivity: .medium)
            }

            Spacer()

            Label("Your Cards", systemImage: "lock")
                .font(.footnote)

            HStack {
                ForEach(0 ..< viewModel.privateListCards.count, id: \.self) { index in
                    if let privateCard = viewModel.privateListCards[index] {
                        CardView(card: privateCard.card, isSelected: privateCard.isSelected)
                            .onTapGesture {
                                viewModel.didTapCard(index, cardType: .private)
                            }
                            .focusable()
                            .digitalCrownRotation($viewModel.privateCardValues[index],
                                                  from: 1,
                                                  through: 14,
                                                  by: 1,
                                                  sensitivity: .medium)
                    } else {
                        PlaceholderView(isSelected: false, iconSize: 16.0)
                            .onTapGesture {
                                viewModel.didTapPlaceholderView(placeholderIndex: index, type: .private)
                            }
                    }
                }
            }

            Spacer()

            Label("Public Cards", systemImage: "lock.open")
                .font(.footnote)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< viewModel.publicListCards.count, id: \.self) { index in
                        if let publicCard = viewModel.publicListCards[index] {
                            CardView(card: publicCard.card, isSelected: publicCard.isSelected)
                                .onTapGesture {
                                    viewModel.didTapCard(index, cardType: .public)
                                }
                                .focusable()
                                .digitalCrownRotation($viewModel.publicCardValues[index],
                                                      from: 1,
                                                      through: 14,
                                                      by: 1,
                                                      sensitivity: .medium)
                        } else {
                            PlaceholderView(isSelected: false, iconSize: 16.0)
                                .onTapGesture {
                                    viewModel.didTapPlaceholderView(placeholderIndex: index, type: .public)
                                }
                        }
                    }
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
