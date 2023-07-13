//
//  QuitDialog.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 07.04.23.
//

import SwiftUI

struct QuitDialog: View {
    @Binding var showBigger : Bool
    @Binding var showAlert : Bool
    @Binding var idArr : [Int]
    @Binding var picture : PictureMadeOfCards
    @Binding var goBack : Bool
    @Binding var goToArtView : Bool
    @Binding var game : ArtModel
    
    var backgroundColor = "Background"
    var textColor = "Foreground"
    var body : some View {
        ZStack {
            Color.clear
            RoundedRectangle(cornerRadius: 10).fill(Color(backgroundColor).opacity(0.9)).shadow(color: .black, radius: 20, x: 10, y: 2)
            VStack(spacing: 20) {
                Text(NSLocalizedString("quitGame?", comment: "quit game?")).font(.title2)
                Text(NSLocalizedString("progLost", comment: "Warning!")).font(.title3)
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if !game.checkIfWon() && !idArr.contains(picture.id) {
                            goToArtView = false
                            showAlert = false
                        } else {
                            showBigger = false
                            showAlert = true
                            
                            goBack = true
                        }
                        
                    }, label: {
                        HStack {
                            Text(NSLocalizedString("quit", comment: ""))
                            Image(systemName: "checkmark.circle").font(.largeTitle)
                        }
                    })
                    Spacer()
                    Button(action: {
                        showAlert = false
                    }, label: {
                        HStack {
                            Text("Cancel")
                            Image(systemName: "x.circle").font(.largeTitle)
                        }
                    })
                    Spacer()
                }
            }.padding().foregroundColor(Color(textColor))
        }.frame(width: 350, height: 200, alignment: .center)
    }
}

