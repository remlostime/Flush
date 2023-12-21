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
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Players")
                        .font(.footnote)
                    PlayersNumberView(number: $viewModel.playersNumberDigitalCrown,
                                      imageSize: .init(width: 14, height: 14),
                                      font: .caption)
                        .onTapGesture {
                            viewModel.isPlayerNumberViewPresented.toggle()
                        }
                        .sheet(isPresented: $viewModel.isPlayerNumberViewPresented, content: {
                            PlayersNumberView(number: $viewModel.playersNumberDigitalCrown)
                        })
                }

                Label("Your Cards", systemImage: "lock")
                    .font(.footnote)

                HStack {
                    ForEach(0 ..< viewModel.privateListCards.count, id: \.self) { index in
                        if let privateCard = viewModel.privateListCards[index] {
                            CardView(card: privateCard.card)
                                .onTapGesture {
                                    viewModel.didTapCard(index, cardType: .private)
                                }
                                .sheet(isPresented: $viewModel.isSelectedCardViewPresented) {
                                    CardPickerDetailsView(listCard: $viewModel.currentSelectedCard)
                                }
                                .frame(height: cardHeight)
                        } else {
                            PlaceholderView(iconSize: 16.0)
                                .onTapGesture {
                                    viewModel.didTapCard(index, cardType: .private)
                                }
                                .sheet(isPresented: $viewModel.isSelectedCardViewPresented) {
                                    CardPickerDetailsView(listCard: $viewModel.currentSelectedCard)
                                }
                                .frame(height: cardHeight)
                        }
                    }
                }

                Label("Public Cards", systemImage: "lock.open")
                    .font(.footnote)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0 ..< viewModel.publicListCards.count, id: \.self) { index in
                            if let publicCard = viewModel.publicListCards[index] {
                                CardView(card: publicCard.card)
                                    .onTapGesture {
                                        viewModel.didTapCard(index, cardType: .public)
                                    }
                                    .sheet(isPresented: $viewModel.isSelectedCardViewPresented) {
                                        CardPickerDetailsView(listCard: $viewModel.currentSelectedCard)
                                    }
                                    .frame(height: cardHeight)
                            } else {
                                PlaceholderView(iconSize: 16.0)
                                    .onTapGesture {
                                        viewModel.didTapCard(index, cardType: .public)
                                    }
                                    .sheet(isPresented: $viewModel.isSelectedCardViewPresented) {
                                        CardPickerDetailsView(listCard: $viewModel.currentSelectedCard)
                                    }
                                    .frame(height: cardHeight)
                            }
                        }
                    }
                }

                Button("Calculate") {
                    board = Board(privateCards: viewModel.privateCards,
                                  publicCards: viewModel.publicCards,
                                  playersNumber: viewModel.playersNumber)
                    viewModel.isResultViewPresented = true
                }
                .sheet(isPresented: $viewModel.isResultViewPresented, content: {
                    ResultView(board: $board)
                })
                .background(.red)
                .clipShape(Capsule())

                Button("Reset") {
                    viewModel.reset()
                }
                .foregroundStyle(.primary)
            }
        }
        .padding()
        .onDisappear {
            board = Board(privateCards: viewModel.privateCards,
                          publicCards: viewModel.publicCards,
                          playersNumber: viewModel.playersNumber)
        }
    }

    // MARK: Private

    private let cardHeight: CGFloat = 60
}

#Preview {
    CardsPickerView(board: Binding<Board>.constant(.initial))
}
