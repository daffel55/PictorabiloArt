//
//  InfoSheetBonusGame.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 08.05.23.
//


import SwiftUI

struct InfoSheetBonusGame: View {
    @Binding var showInfoSheet : Bool
    var body: some View {
        ZStack {
            backC.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center, spacing: 40) {
                    Text("Bonusspiel").font(.largeTitle).padding(.top, 10)
                    
                    
                    Text(NSLocalizedString("bonusGameExpl", comment: "Bouns game explained")).padding(.bottom, 20)
                        .foregroundColor(foreC).font(.title).padding(.horizontal)
                    
                    Button(action: {
                        showInfoSheet = false
                    }) {
                        Text("zurück")
                            .font(.title2)
                            .padding()
                            .foregroundColor(backC)
                            .background(foreC)
                            .border(foreC)
                    }
                    
                    
                }
                
            }
        }
    }
}

