//
//  PlaceholderView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

struct PlaceholderView: View {
    // MARK: Lifecycle

    init(iconSize: CGFloat = 32.0) {
        self.iconSize = iconSize
    }

    // MARK: Internal

    let iconSize: CGFloat

    var body: some View {
        ZStack {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.primary)
                .font(.system(size: iconSize, weight: .bold, design: .rounded))

            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5),
                             style: .circular)
                .strokeBorder(.primary)
                .aspectRatio(0.74, contentMode: .fit)
        }
    }
}

#Preview {
    PlaceholderView()
}
