//
//  BonusMiniGameView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 26.04.23.
//

import SwiftUI

struct BonusMiniGameView: View {
    @Binding var goToAlternative : Bool
    @State var game = BonusMiniGameModel()
    @State private var showInfoSheet = false
    var body: some View {
        if game.gameOver {
            ZStack {
                Color(.white).ignoresSafeArea()
                VStack {
                    Text(NSLocalizedString("gameOver", comment: "")).font(.system(size: 60))
                    Text(setTextForGameOver()).font(.title)
                    Button(NSLocalizedString("again", comment: "")) {
                        reset()
                        
                    }.buttonStyle(ChooseButton())
                    Button(NSLocalizedString("mainMenu", comment: "")) {
                        goToAlternative = false
                    }.buttonStyle(ChooseButton())
                }.foregroundColor(backC)
                    .padding()
            }
        }
        else if showInfoSheet {
            InfoSheetBonusGame(showInfoSheet: $showInfoSheet)
        }
        else {
            ZStack(alignment: .center) {
                backC.ignoresSafeArea()
                VStack(spacing: 2) { //dieser VStack hält die ganzen HStacks (das ist also das Raster für die 25 Bilder)
                    
                    
                    VStack(alignment: .center) {
                        Text(NSLocalizedString("pressOn", comment: "Click on art made by")).font(.title3)
                        Text(game.randomArtist).font(.title)
                        HStack {
                            Image(systemName: "exclamationmark.triangle").foregroundColor(game.lostTry ? .red : .black)
                            Text("\(game.currentTries)/\(game.possibleTries)")
                            Text(game.lostTry ? setTextForError() : "")
                        }.font(.title2)
                        
                    }.foregroundColor(.white)
                        .padding(.horizontal, 4)
                    
                    
                    HStack(spacing: 2){
                        ForEach(0 ..< 5) { i in
                            if !game.pictures[i].matched {
                                
                                
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                
                                    .onTapGesture {
                                        game.correctPic(pic: game.pictures[i])
                                        SoundManager.instance.playSound(sound: game.playSoundOhNo ? .ohno : .swap, soundtype: .m4a)
                                    }
                            } else {
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                    .hidden()
                            }
                        }
                        
                    }
                    
                    HStack(spacing: 2) { //2. HSTack
                        ForEach(5 ..< 10) { i in
                            if !game.pictures[i].matched {
                                
                                
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                
                                    .onTapGesture {
                                        game.correctPic(pic: game.pictures[i])
                                        SoundManager.instance.playSound(sound: game.playSoundOhNo ? .ohno : .swap, soundtype: .m4a)
                                    }
                            } else {
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                    .hidden()
                            }
                        }
                    }
                    HStack(spacing: 2) { //3.HStack
                        ForEach(10 ..< 15) { i in
                            if !game.pictures[i].matched {
                                
                                
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                
                                    .onTapGesture {
                                        game.correctPic(pic: game.pictures[i])
                                        SoundManager.instance.playSound(sound: game.playSoundOhNo ? .ohno : .swap, soundtype: .m4a)
                                    }
                            } else {
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                    .hidden()
                            }
                        }
                    }
                    HStack(spacing: 2) { //4.HStack
                        ForEach(15 ..< 20) { i in
                            if !game.pictures[i].matched {
                                
                                
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                
                                    .onTapGesture {
                                        game.correctPic(pic: game.pictures[i])
                                        SoundManager.instance.playSound(sound: game.playSoundOhNo ? .ohno : .swap, soundtype: .m4a)
                                    }
                            } else {
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                    .hidden()
                            }
                        }
                    }
                    HStack(spacing: 2) { //5. HStack
                        ForEach(20 ..< 25) { i in
                            if !game.pictures[i].matched {
                                
                                
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                
                                    .onTapGesture {
                                        game.correctPic(pic: game.pictures[i])
                                        SoundManager.instance.playSound(sound: game.playSoundOhNo ? .ohno : .swap, soundtype: .m4a)
                                    }
                            } else {
                                Image(game.pictures[i].name)
                                    .resizable()
                                    .scaledToFit()
                                    .hidden()
                            }
                        }
                    }
                    
                    
                    
                }
                
                
            }.onAppear(perform: {
                game.generateNewRandomArtist()
            })
            .overlay(
                Button(action: {
                    goToAlternative = false
                }) {
                    Image(systemName: "arrowshape.turn.up.left")
                        .font(.title3)
                        .padding()
                        .foregroundColor(backC)
                        .background(backC)
                        .border(foreC)
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading),
                alignment: .topLeading
            )
            .overlay(
                Button(action: {
                    showInfoSheet = true
                }) {
                    Image(systemName: "info.circle")
                        .font(.title3)
                        .padding()
                        .foregroundColor(backC)
                        .background(foreC)
                        .border(foreC)
                }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .trailing),
                alignment: .topLeading
            )
            .sheet(isPresented: $game.gameWon, content: {
                VStack {
                    Text("Alle Teile richtig gefunden!")
                    Button("Noch einmal") {
                        reset()
                        game.generateNewRandomArtist()
                    }.buttonStyle(ChooseButton())
                    Button("Zum Hauptmenü") {
                        goToAlternative = false
                    }.buttonStyle(ChooseButton())
                }
            })
        } //else
    }//body
    
    func setTextForGameOver() -> String {
        var text = ""
        text.append(NSLocalizedString("gameOverText1", comment: "this art is from..."))
        text.append(game.chosenArtist)
        text.append(NSLocalizedString("gameOverText12", comment: "but you should have looked for..."))
        text.append(game.randomArtist)
        text.append(".")
        return text
    }
    func setTextForError() -> String {
        var text = ""
        text.append(NSLocalizedString("worngArt", comment: "this was from"))
        text.append(game.chosenArtist)
        return text
    }
    
    
    
    func reset() {
        arrayOfPics.shuffle()
        game = BonusMiniGameModel()
        
    }
}












   

