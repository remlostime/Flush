//
//  RankRateView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/13/23.
//

import SwiftUI

extension Double {
    var percentage: String {
        String(format: "%.2f%%", self)
    }
}

// MARK: - RankRateView

struct RankRateView: View {
    let rank: Rank
    let rate: Double

    var body: some View {
        HStack {
            Text(rank.description)
            Text(rate.percentage)
        }
    }
}

#Preview {
    RankRateView(rank: .flush, rate: 0.123)
}
