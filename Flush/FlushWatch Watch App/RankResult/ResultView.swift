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
    }

    // MARK: Internal

    @Binding var board: Board

    var viewModel: ResultViewModel {
        ResultViewModel(board: board)
    }

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
    }
}

#Preview {
    ResultView(board: Binding<Board>.constant(.initial))
}
