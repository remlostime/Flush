//
//  PlayersNumberView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/16/23.
//

import SwiftUI

struct PlayersNumberView: View {
    var number: Int

    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
            Text("\(number)")
        }
    }
}

#Preview {
    PlayersNumberView(number: 2)
}
