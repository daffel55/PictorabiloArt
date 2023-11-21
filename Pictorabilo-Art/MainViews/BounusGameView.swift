//
//  BonusGameView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 04.06.23.
//

import SwiftUI

//
//  BonusMiniGameView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 26.04.23.
//

import SwiftUI
///  Bonusgame presents 25 detail pics and artist name, user has to match artist and pic
struct BonusGameView: View {
    @Binding var gotoBonusGame : Bool
    @State var game = BonusGameModel()
    @State private var showInfoSheet = false
    var body: some View {
        if showInfoSheet {
            InfoSheetBonusGame(showInfoSheet: $showInfoSheet)
        }
        else {
            ZStack(alignment: .center) {
                Color.darkStandard.ignoresSafeArea()
                VStack(spacing: 2) {
                    VStack(alignment: .center) {
                        Text(NSLocalizedString("pressOn", comment: "Click on art made by")).font(.title3)
                        Text(game.randomArtist).font(.title)
                        HStack {
                            Image(systemName: "exclamationmark.triangle").foregroundColor(game.lostTry ? .red : .lightStandard)
                            Text("\(game.currentTries)/\(game.possibleTries)")
                            Text(game.lostTry ? setTextForError() : "")
                        }.font(.title2)
                        
                    }.foregroundColor(.white)
                        .padding(.horizontal, 4)
                    ForEach(0..<5) {row in
                        HStack(spacing: 2){
                            ForEach(0 ..< 5) { col in
                                if !game.pictures[row*5+col].matched {
                                    Image(game.pictures[row*5+col].name)
                                        .resizable()
                                        .scaledToFit()
                                        .onTapGesture {
                                            game.processTap(pic: game.pictures[row*5+col])
                                            if game.gameWon {
                                                SoundManager.instance.playSound(sound: .bell , soundtype: .mp3)
                                            } else {
                                                SoundManager.instance.playSound(sound: game.playSoundOhNo ? .ohno : .swap, soundtype: .m4a)
                                            }
                                        }
                                } else {
                                    Image(game.pictures[row*5+col].name)
                                        .resizable()
                                        .scaledToFit()
                                        .hidden()
                                }
                            }
                        }
                    }
                    BottomButton(numberOfButton: 2, buttonActions: [{
                        gotoBonusGame = false
                    }, {
                        showInfoSheet = true
                    }], imageNames: ["arrowshape.turn.up.left","info.circle" ],
                                 texts: isIPad ? [NSLocalizedString("back", comment: ""), "Info"] : ["",""])
                }
                       
                
            }.onAppear(perform: {
                game.generateNewRandomArtist()})
            .sheet(isPresented: $game.gameWon, content: {
                VStack {
                    Text(NSLocalizedString("gameWon", comment: "")).textStyleLarge(deviceType: deviceType)
                    Button(NSLocalizedString("again", comment: "")) {
                        reset()
                        game.generateNewRandomArtist()
                    }.buttonStyle(ChooseButton())
                    Button(NSLocalizedString("mainMenu", comment: "")) {
                        gotoBonusGame = false
                    }.buttonStyle(ChooseButton())
                }
            })
            .sheet(isPresented: $game.gameOver, content: {
             
                    VStack {
                        Text(NSLocalizedString("gameOver", comment: "")).textStyleLarge(deviceType: deviceType)
                        Button(NSLocalizedString("again", comment: "")) {
                            reset()
                        }.buttonStyle(ChooseButton())
                        Button(NSLocalizedString("mainMenu", comment: "")) {
                            gotoBonusGame = false
                        }.buttonStyle(ChooseButton())
                    }.foregroundColor(Color.darkStandard)
                        .padding()
                
            })
            
            
        } //else
    }//body

    func setTextForError() -> String {
        var text = ""
        text.append(NSLocalizedString("worngArt", comment: "this was from"))
        text.append(game.chosenArtist)
        return text
    }
    
    
    
    func reset() {
        arrayOfPics.shuffle()
        game = BonusGameModel()
        
    }
}














