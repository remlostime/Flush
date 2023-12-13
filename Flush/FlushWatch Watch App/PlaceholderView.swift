//
//  PlaceholderView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

struct PlaceholderView: View {
    let isSelected: Bool

    var body: some View {
        ZStack {
            Text("?")

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
