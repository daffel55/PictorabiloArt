//
//  InfoSheetBonusGame.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 04.06.23.
//MARK: NEU

import SwiftUI


/// a view that shows infos about bonus game
struct InfoSheetBonusGame: View {
    @Binding var showInfoSheet : Bool
    var body: some View {
        ZStack {
            Color.darkStandard.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center, spacing: 40) {
                    Text(NSLocalizedString("bonusgame", comment: "")).font(.largeTitle).padding(.top, 10)
                    Text(NSLocalizedString("bonusGameExpl", comment: "Bouns game explained")).padding(.bottom, 20)
                        .foregroundColor(.lightStandard).font(.title).padding(.horizontal)
                    Button(action: {
                        showInfoSheet = false
                    }) {
                        Text("zurück")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.darkStandard)
                            .background(Color.lightStandard)
                            .border(Color.lightStandard)
                    }
                }
            }
        }
    }
}


