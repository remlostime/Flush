//
//  RankRateView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI
import RankRateService

extension Double {
    var percentage: String {
        let percentage = Int(self * 100.0)
        return "\(percentage)%"
    }
}

// MARK: - RankRateView

public struct RankRateView: View {
    let rankRate: RankRate

    public var body: some View {
        HStack {
            Text(rankRate.rank.description)
            Spacer()
            Text(rankRate.rate.percentage)
        }
    }
}

#Preview {
    RankRateView(rankRate: RankRate(rank: .flush, rate: 0.123))
}
