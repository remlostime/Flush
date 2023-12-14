//
//  PrivateCardsDetailsView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

struct PrivateCardsDetailsView: View {
    @Bindable var viewModel: PrivateCardsDetailsViewModel

    var body: some View {
        HStack {
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

            List(Rank.allCases) { rank in
                RankRateView(rank: rank, rate: 0.12)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
            }
        }
        .padding()
    }
}

#Preview {
    PrivateCardsDetailsView(viewModel: .empty)
}
