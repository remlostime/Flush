//
//  PlaceholderView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

struct PlaceholderView: View {
    let isSelected: Bool
    let iconSize: CGFloat

    init(isSelected: Bool, iconSize: CGFloat = 32.0) {
        self.isSelected = isSelected
        self.iconSize = iconSize
    }

    var body: some View {
        ZStack {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(isSelected ? .cyan : .primary)
                .font(.system(size: iconSize, weight: .bold, design: .rounded))

            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5),
                             style: .circular)
                .strokeBorder(isSelected ? .cyan : .primary, lineWidth: 1)
        }
    }
}

#Preview {
    PlaceholderView(isSelected: true)
}

#Preview {
    PlaceholderView(isSelected: false)
}
