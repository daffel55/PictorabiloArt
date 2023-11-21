//
//  SecondMenuView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 28.05.23.
//MARK: NEU

import SwiftUI

struct SecondMenuView: View {
    @Binding var game: ArtGameModel
    //@Binding var idArr : [Int]
    @Binding var user : UserData
    @State var playmode = PlayMode.standardLines
    //@State var randomImage = ""
    @State var gotoArtGame = false
    @State var goToMainMenu = false
    @State var gotToMiniGame = false
    @State var showSettings = false
    @State var showInfoSheet = false
    @State var showPainter = true //Textanzeige mit Infos über den Künstler
    @State var gotoMiniGameLarge = false
    @AppStorage("timeInterval") var timeInterval = 5.0
    @AppStorage("withTimer") var withTimer = false
    var body: some View {
        GeometryReader { geo in
            if gotoArtGame {
                ArtGame(user: $user, gotoArtGame: $gotoArtGame, playmode: $playmode, game: game)
            } else if goToMainMenu {
                
                MainMenuView()
            }
            else if gotToMiniGame {
                MiniGameView(picture: game.picture, goBack: $gotToMiniGame, user: $user)
            }
            else if gotoMiniGameLarge {
                MiniGameLarge(picture: game.picture, goBack: $gotoMiniGameLarge, user: $user)
            }
            else {
                GeometryReader { geo in
                    ZStack {
                        Color.darkStandard.ignoresSafeArea()
                        
                        if showPainter {
                            ZStack {
                                Color.darkStandard.ignoresSafeArea()
                                VStack {
                                    PainterView(game: $game)
                                    BottomButton(numberOfButton: 1, buttonActions: [{
                                        showPainter = false
                                    }], imageNames: ["checkmark.circle"], texts: ["OKAY"])
                                }
                            }
                        }
                        else {
                            VStack {
                                Group {
                                    Text("\(String(game.picture.artistData.fullName))").font(.title)
                                    Text(NSLocalizedString("choosePlayMode", comment: "")).font(.title2)
                                }.foregroundColor(.lightStandard)
                                ScrollView(.vertical) {
                                    HStack {
                                        Spacer()
                                        VStack(alignment: .center) {
                                            Button("STANDARD") {
                                                playmode = PlayMode.standardLines
                                                gotoArtGame = true
                                            }.buttonStyle(ChooseButton())
                                                .overlay(alignment: .bottomTrailing, content: {
                                                    Image(systemName: "checkmark").foregroundColor(checkIfDictContainsValue(mode: .standardLines) ? .darkStandard : .clear).font(.title).padding()
                                                })
                                            Button(NSLocalizedString("easy", comment: "")) {
                                                playmode = PlayMode.standardColor
                                                gotoArtGame = true
                                                //withTimer = true
                                            }.buttonStyle(ChooseButton())
                                                .overlay(alignment: .bottomTrailing, content: {
                                                    Image(systemName: "checkmark").foregroundColor(checkIfDictContainsValue(mode: .standardColor) ? .darkStandard : .clear).font(.title).padding()
                                                })
                                            Button("TRICKY") {
                                                playmode = PlayMode.reverseColor
                                                gotoArtGame = true
                                                //withTimer = true
                                            }.buttonStyle(ChooseButton())
                                                .overlay(alignment: .bottomTrailing, content: {
                                                    Image(systemName: "checkmark").foregroundColor(checkIfDictContainsValue(mode: .reverseColor) ? .darkStandard : .clear).font(.title).padding()
                                                })
                                            Button(NSLocalizedString("hard", comment: "")) {
                                                playmode = PlayMode.reverseLines
                                                gotoArtGame = true
                                                //withTimer = true
                                            }.buttonStyle(ChooseButton())
                                                .overlay(alignment: .bottomTrailing, content: {
                                                    Image(systemName: "checkmark").foregroundColor(checkIfDictContainsValue(mode: .reverseLines) ? .darkStandard : .clear).font(.title).padding()
                                                })
                                            Spacer()
                                            Button(NSLocalizedString("bonus1", comment: "")) {
                                                gotToMiniGame = true
                                            }.buttonStyle(ChooseButton(fillColor: Color("Color_orange")))
                                                .overlay(alignment: .bottomTrailing, content: {
                                                    Image(systemName: "checkmark").foregroundColor(checkIfDictContainsValue(mode: .bonus1) ? .darkStandard : .clear).font(.title).padding()
                                                })
                                            Button(NSLocalizedString("bonus2", comment: "")) {
                                                gotoMiniGameLarge = true
                                            }.buttonStyle(ChooseButton(fillColor: Color("Color_orange")))
                                                .overlay(alignment: .bottomTrailing, content: {
                                                    Image(systemName: "checkmark").foregroundColor(checkIfDictContainsValue(mode: .bonus2) ? .darkStandard : .clear).font(.title).padding()
                                                })
                                            Spacer()
                                            
                                        }
                                        Spacer()
                                    }
                                } .foregroundColor(.lightStandard)
                                
                                if isIPad {
                                    BottomButton(numberOfButton: 3, buttonActions: [{
                                        goToMainMenu = true
                                    }, {
                                        showSettings = true
                                    },{
                                        showInfoSheet = true
                                    }],imageNames:  ["arrowshape.turn.up.left", "gearshape", "info.circle"] , texts: [GameConstants.backText, NSLocalizedString("settings", comment: ""),"Info"])
                                } else {
                                    BottomButton(numberOfButton: 3, buttonActions: [{
                                        goToMainMenu = true
                                    }, {
                                        showSettings = true
                                    },{
                                        showInfoSheet = true
                                    }], imageNames: ["arrowshape.turn.up.left", "gearshape", "info.circle"], texts: ["","",""])
                                }
                            }
                            .sheet(isPresented: $showInfoSheet, content: {
                                InfoSheet(showInfoSheet: $showInfoSheet)
                            })
                        } // 2. else
                        if showSettings {
                                   SettingsView(showSettings: $showSettings, geo: geo)
                                      
                       }
                    } //ZStack
                    
                } // geometry
            } // 1. else
        }
    } // body
    
    func checkIfDictContainsValue(mode: PlayMode) -> Bool {
        
        let  val = user.playedDict[game.picture.id]!
                for index in val.indices {
                    if val[index] == mode.rawValue {
                        return true
                    }
                }
            
        
        return false
    }
} // View


