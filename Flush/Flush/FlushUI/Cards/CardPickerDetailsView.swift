//
//  CardPickerDetailsView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/20/23.
//

import SwiftUI

extension View {
    func digitalCrownRotation(value: Binding<Double>) -> some View {
        /* Fix this func
        if #available(watchOS 9.0, *) {
            return self.digitalCrownRotation($value,
                                             from: 1,
                                             through: 14,
                                             by: 1,
                                             sensitivity: .medium)
        } else {
            return self
        }
         */
        return self
    }
}

public struct CardPickerDetailsView: View {
    // MARK: Lifecycle

    public init(listCard: Binding<ListCard>) {
        _listCard = listCard
//        cardValues = Double(listCard.card.number.rawValue.wrappedValue)
    }

    // MARK: Internal

    @Binding var listCard: ListCard

    @State var cardValues: Double = 1 {
        didSet {
            print(cardValues)
            let card = Card(kind: listCard.card.kind, number: Int(cardValues))
            listCard = ListCard(card: card, id: UUID())
        }
    }

    public var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                ForEach(Kind.allCases, id: \.self) { kind in
                    Button(action: {
                        let card = Card(kind: kind, number: listCard.card.number)
                        listCard = ListCard(card: card, id: UUID())
                    }, label: {
                        Image(systemName: kind.imageName)
                            .foregroundStyle(kind.color)
                            .imageScale(.large)
                    })
                    .buttonStyle(.borderless)
                }
            }

            CardView(card: listCard.card)
                .frame(height: 60)
                // TODO: - focus does not work
                .focusable()
                .digitalCrownRotation(value: $cardValues)

            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Number.allCases, id: \.self) { number in
                        Button(action: {
                            let card = Card(kind: listCard.card.kind, number: number)
                            listCard = ListCard(card: card, id: UUID())
                        }, label: {
                            Image(systemName: number.imageName)
                                .imageScale(.large)
                        })
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
    }
}

#Preview {
    CardPickerDetailsView(listCard: Binding<ListCard>.constant(.initial))
}
