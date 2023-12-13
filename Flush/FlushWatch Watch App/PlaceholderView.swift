//
//  PlaceholderView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        ZStack {
            Text("?")
            
            RoundedRectangle(cornerSize: CGSize(width: 5, height: 5),
                             style: .circular)
            .strokeBorder(.primary, lineWidth: 1)
        }
    }
}

#Preview {
    PlaceholderView()
}
