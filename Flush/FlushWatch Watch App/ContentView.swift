//
//  ContentView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                CardView(card: .heartA)
                CardView(card: .clubQ)
            }
            Spacer()
                .frame(maxHeight: 32)
            Text("48%")
        }
    }
}

#Preview {
    ContentView()
}
