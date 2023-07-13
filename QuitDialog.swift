//
//  QuitDialog.swift
//  MemoGame
//
//  Created by Dagmar Feldt on 16.11.22.
//

import SwiftUI

struct QuitDialog: View {
    @Binding var showBigger : Bool
    @Binding var showAlert : Bool
    @Binding var allDealt : Bool
    @Binding var goBack : Bool
    
    var backgroundColor = "brightYellowBackground"
    var textColor = "TextColor"
    var body : some View {
        ZStack {
            Color.clear
            RoundedRectangle(cornerRadius: 10).fill(Color(backgroundColor).opacity(0.9)).shadow(color: .black, radius: 20, x: 10, y: 2)
            VStack(spacing: 20) {
                Text("Dieses Spiel verlassen?").font(.title2)
                Text("Der Spielstand geht verloren!").font(.title3)
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showBigger = false
                        showAlert = true
                        allDealt = false
                        goBack = true
                        
                    }, label: {
                        HStack {
                            Text("Verlassen")
                            Image(systemName: "checkmark.circle").font(.largeTitle)
                        }
                    })
                    Spacer()
                    Button(action: {
                        showAlert = false
                    }, label: {
                        HStack {
                            Text("Hier bleiben")
                            Image(systemName: "x.circle").font(.largeTitle)
                        }
                    })
                    Spacer()
                }
            }.padding().foregroundColor(Color(textColor))
        }.frame(width: 350, height: 200, alignment: .center)
    }
}

