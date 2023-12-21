//
//  CardPickerDetailsView.swift
//  FlushWatch Watch App
//
//  Created by Kai Chen on 12/20/23.
//

import SwiftUI

struct CardPickerDetailsView: View {
    @Binding var listCard: ListCard
    @State var cardValues: Double = 1 {
        didSet {
            print(cardValues)
            let card = Card(kind: listCard.card.kind, number: Int(cardValues))
            listCard = ListCard(card: card, id: UUID())
        }
    }

    init(listCard: Binding<ListCard>) {
        _listCard = listCard
//        cardValues = Double(listCard.card.number.rawValue.wrappedValue)
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(Kind.allCases, id: \.self) { kind in
                    Button(action: {
                        let card = Card(kind: kind, number: listCard.card.number)
                        listCard = ListCard(card: card, id: UUID())
                    }, label: {
                        Image(systemName: kind.imageName)
                            .foregroundStyle(kind.color)
                    })
                    .buttonBorderShape(.automatic)
                }
            }

            CardView(card: listCard.card)
                .frame(height: 80)
                // TODO - focus does not work
                .focusable()
                .digitalCrownRotation($cardValues,
                                      from: 1,
                                      through: 14,
                                      by: 1,
                                      sensitivity: .medium)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(Number.allCases, id: \.self) { number in
                        Button(action: {
                            let card = Card(kind: listCard.card.kind, number: number)
                            listCard = ListCard(card: card, id: UUID())
                        }, label: {
                            Image(systemName: number.imageName)
                        })
                        .buttonBorderShape(.automatic)
                    }
                }
            }
        }
    }
}

#Preview {
    CardPickerDetailsView(listCard: Binding<ListCard>.constant(.initial))
}
