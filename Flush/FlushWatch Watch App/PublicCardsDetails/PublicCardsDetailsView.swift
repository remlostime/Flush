//
//  PublicCardsDetailsView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

struct PublicCardsDetailsView: View {
    @Bindable var viewModel: PublicCardsDetailsViewModel

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
                        ForEach(viewModel.publicCards, id: \.self) { publicCard in
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

            List(Rank.allCases) { rank in
                RankRateView(rank: rank, rate: 0.12)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
            }
        }
        .padding()
    }
}

#Preview {
    PublicCardsDetailsView(viewModel: .empty)
}
