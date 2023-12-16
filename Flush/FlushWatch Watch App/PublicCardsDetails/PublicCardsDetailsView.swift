//
//  PublicCardsDetailsView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

struct PublicCardsDetailsView: View {
    // MARK: Lifecycle

    init(board: Binding<Board>) {
        _board = board
        viewModel = PublicCardsDetailsViewModel(board: board.wrappedValue)
    }

    // MARK: Internal

    @Bindable var viewModel: PublicCardsDetailsViewModel
    @Binding var board: Board

    var body: some View {
        HStack {
            VStack {
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
                        ForEach(viewModel.publicListCards, id: \.self) { publicCard in
                            if let publicCard = publicCard {
                                CardView(card: publicCard.card, isSelected: publicCard.isSelected)
                            } else {
                                PlaceholderView(isSelected: false, iconSize: 16.0)
                            }
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
        }
        .padding()
        .onDisappear {
            board = Board(privateCards: viewModel.privateCards, publicCards: viewModel.publicCards)
        }
    }
}

#Preview {
    PublicCardsDetailsView(board: Binding<Board>.constant(.initial))
}
