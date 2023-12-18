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
        VStack {
            Text(viewModel.winRatePercent)

            List(viewModel.rankRate) { rankRate in
                RankRateView(rankRate: rankRate)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
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
