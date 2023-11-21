//
//  InfoSheet.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 03.05.23.
//

import SwiftUI

struct InfoSheet: View {
    @Binding var showInfoSheet : Bool
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Vier Arten 'Art' zu spielen:").font(.largeTitle).padding(.bottom, 10)
                    Group{
                        Text("Achtung!")
                            .foregroundColor(Color("Color_orange"))
                                .font(.title)
                                .padding(.bottom, 0)
                        Text(NSLocalizedString("timerInfoText", comment: "Info about timer")).padding(10).border(Color("Color_orange")).padding(.bottom, 20)
                    }.foregroundColor(.lightStandard).font(.title).padding(.horizontal)
                    Group {
                        
                        Text("STANDARD").padding(.bottom, 0).font(.title)
                        Text(NSLocalizedString("standardExpl", comment: "standard explained"))
                        Text(NSLocalizedString("easy", comment: "")).padding(.bottom, 0).font(.title)
                        Text(NSLocalizedString("easyExpl", comment: "easy exlained"))
                        Text("TRICKY").padding(.bottom, 0).font(.title)
                        Text(NSLocalizedString("trickyExpl", comment: "tricky explained"))
                        Text(NSLocalizedString("hard", comment: "")).padding(.bottom, 0).font(.title)
                        Text(NSLocalizedString("hardExpl", comment: "hard explained"))
                    }.foregroundColor(.lightStandard).font(.title2).padding(.horizontal)
                    

                    Group {
                        Text(NSLocalizedString("bonusGames", comment: "")).padding(.bottom, 0).font(.title)
                        Text(NSLocalizedString("bonusExpl", comment: "bonus games explained"))
                    }.foregroundColor(.lightStandard).font(.title2).padding(.horizontal)
                    Group {
                        Text("EINSTELLUNGEN").font(.title)
                        Text(NSLocalizedString("infoSettings", comment: "Settings explained"))
                        
                    }.foregroundColor(.lightStandard).font(.title2).padding(.horizontal)
                
                    
                    
                }
                
            }
            .padding(50)
            .overlay(
                Button(action: {
                    showInfoSheet = false
                }) {
                    Text("zurück")
                        .font(.title2)
                        .padding()
                        .foregroundColor(.darkStandard)
                        .background(Color("Color_marker"))
                        .cornerRadius(10)
                        .border(Color.lightStandard)
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing),
                alignment: .topTrailing
            )
        }
        
    }
}

