//
//  RankRateView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

extension Double {
    var percentage: String {
        let percentage = Int(self * 100.0)
        return "\(percentage)%"
    }
}

// MARK: - RankRateView

struct RankRateView: View {
    let rankRate: RankRate

    var body: some View {
        HStack {
            Text(rankRate.rank.description)
            Text(rankRate.rate.percentage)
        }
    }
}

#Preview {
    RankRateView(rankRate: RankRate(rank: .flush, rate: 0.123))
}
