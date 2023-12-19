//
//  ResultView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

struct ResultView: View {
    // MARK: Lifecycle

    init(board: Binding<Board>) {
        _board = board
        viewModel = ResultViewModel(board: board.wrappedValue)
    }

    // MARK: Internal

    @Bindable var viewModel: ResultViewModel
    @Binding var board: Board

    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.winRatePercent)

                ForEach(viewModel.rankRate) { rankRate in
                    RankRateView(rankRate: rankRate)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .background(rankRate.rank.rawValue % 2 == 1 ? .secondary : Color.black)
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
    ResultView(board: Binding<Board>.constant(.initial))
}
