//
//  QuitDialog.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 01.06.23.
//MARK: NEU 

import SwiftUI
/// Warning before user quits the game, shows option to cancel or to proceed
struct QuitDialog: View {
    
    @Binding var control : GameViewControl
    @Binding var gotoArtGame : Bool //if set to false, the game return to mainmenu, which only happens if picture i splayed first time
    @Binding var game : ArtGameModel
    
    
    var body : some View {
        ZStack(alignment: .center) {
            Color.darkStandard
            RoundedRectangle(cornerRadius: 10).fill(Color.darkStandard.opacity(0.9)).shadow(color: .black, radius: 20, x: 10, y: 2)
            VStack(spacing: 20) {
                Text(NSLocalizedString("quitGame?", comment: "quit game?")).font(.title2)
                Text(NSLocalizedString("progLost", comment: "Warning!")).font(.title3)
                HStack {
                    Spacer()
                    Button(action: {
                            game.resetGame()
                            gotoArtGame = false //verlässt Artgame in die Richtung in der zu Artgame gegangen wurde...also entweder MainMenu oder SecondMenu
                    }, label: {
                        HStack {
                            Text(NSLocalizedString("quit", comment: ""))
                            Image(systemName: "checkmark.circle").font(.largeTitle)
                        }
                    })
                    Spacer()
                    Button(role: .destructive , action: {
                        control.showQuitDialog = false
                    }, label: {
                        HStack {
                            Text("Cancel")
                            Image(systemName: "x.circle").font(.largeTitle)
                        }
                    })
                    Spacer()
                }
            }.padding().foregroundColor(Color.lightStandard)
        }.frame(width: 350, height: 200, alignment: .center)
    }
}

