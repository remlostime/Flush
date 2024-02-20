//
//  PlayersNumberView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/16/23.
//

import SwiftUI
import FlushModel

public struct PlayersNumberView: View {
    // MARK: Lifecycle

    init(number: Binding<Double>,
         imageSize: CGSize = .init(width: 40, height: 40),
         font: Font = .system(size: 45))
    {
        _number = number
        self.imageSize = imageSize
        self.font = font
    }

    // MARK: Internal

    @Binding var number: Double

    var playerNumber: Int {
        Int(number)
    }

    public var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: imageSize.width, height: imageSize.height)
            Text("\(playerNumber)")
                .font(font)
        }
        .focusable()
        .digitalCrownRotation($number,
                              from: Double(Board.MinPlayerNumber),
                              through: Double(Board.MaxPlayerNumber),
                              by: 1,
                              sensitivity: .medium)
    }

    // MARK: Private

    private let imageSize: CGSize
    private let font: Font
}

#Preview {
    PlayersNumberView(number: Binding<Double>.constant(2.0))
}
