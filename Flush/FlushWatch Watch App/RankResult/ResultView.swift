//
//  ResultView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI
import FlushUI
import FlushModel

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
            VStack(spacing: 0) {
                Text(viewModel.winRatePercent)

                ForEach(viewModel.rankRate) { rankRate in
                    RankRateView(rankRate: rankRate)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(rankRate.rank.rawValue % 2 == 1 ? .secondary : Color.black)
                        .containerShape(.rect(cornerRadius: 5))
                }
            }
        }
        .padding()
    }
}

#Preview {
    ResultView(board: Binding<Board>.constant(.initial))
}
