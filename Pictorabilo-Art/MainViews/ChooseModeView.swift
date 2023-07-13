//
//  ChooseModeView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 18.04.23.
//

import SwiftUI

struct ChooseModeView: View {
    @Binding var picture : PictureMadeOfCards
    @Binding var imageArray : [Card]
    //@Binding var selectionsNumber: Int
    @Binding var withTimer : Bool
   
    @Binding var idArr : [Int]
    @State var playMode = PlayMode.standardLines
    @State var randomImage = ""
    @State var gotoArtView = false
    @State var goToSelectionView = false
    @State var gotToMiniGame = false
    @State var showSettings = false
    @State var showInfoSheet = false
    @State var showPainter = true
    @State var gotoMiniGameLarge = false
    @AppStorage("timeInterval") var timeInterval = 2.0
    var body: some View {
        if gotoArtView {
            ArtView25x25(game: ArtModel(imageArray: imageArray, randomCard: imageArray.randomElement()!, playmode: playMode),picture: $picture, goToArtView: $gotoArtView, playmode: $playMode, withTimer: $withTimer, idArr: $idArr)
        } else if goToSelectionView {
            
            SelectionView()
        }
        else if showSettings {
            SettingsView(timeInterval: $timeInterval, showSettings: $showSettings, withTimer: $withTimer)
        }
        else if gotToMiniGame {
            MiniGameView(picture: $picture, goBack: $gotToMiniGame)
        }
        else if gotoMiniGameLarge {
            MiniGameLarge(picture: $picture, goBack: $gotoMiniGameLarge)
        }
        else {
            GeometryReader { geo in
                ZStack {
                    Color("Background").ignoresSafeArea()
                    if showPainter {
                        ScrollView {
                            VStack(spacing: 40) {
                                Spacer()
                                Text(picture.painterText)
                                    .font(.title)
                                    .padding()
                                    .border(.green, width: 2)
                                    .padding()
                                    .foregroundColor(backC)
                                    .background(content: {
                                        foreC
                                    })
                                    .padding()
                                Button("OKAY") {
                                    showPainter = false
                                }.buttonStyle(ChooseButton())
                                Spacer()
                            }
                        }
                        
                    }
                    else {
                        ScrollView(.vertical) {
                            VStack(alignment: .center) {
                                
                                
                                Text(NSLocalizedString("moreModes", comment: "more modes to play")).font(.largeTitle).padding(.bottom,0).padding(.horizontal,20).padding(.top, 80).padding(.bottom, 10)
                                Button(action: {
                                    showInfoSheet = true
                                }, label: {
                                    Text(NSLocalizedString("moreInfo", comment: "more Info")).font(.title).underline()
                                })
                                
                            }.sheet(isPresented: $showInfoSheet, content: {
                                InfoSheet(showInfoSheet: $showInfoSheet)
                            })
                            
                            HStack {
                                Spacer()
                                VStack(alignment: .center) {
                                    HStack {
                                        Button("STANDARD") {
                                            playMode = PlayMode.standardLines
                                            randomImage = imageArray.randomElement()!.content.0
                                            gotoArtView = true
                                            withTimer = true
                                        }.buttonStyle(ChooseButton())
                                  
                                    }
                                    HStack {
                                        Button(NSLocalizedString("easy", comment: "")) {
                                            playMode = PlayMode.standardColor
                                            randomImage = imageArray.randomElement()!.content.1
                                            gotoArtView = true
                                            withTimer = true
                                        }.buttonStyle(ChooseButton())
                                   
                                    }
                                    HStack{
                                        Button("TRICKY") {
                                            playMode = PlayMode.reverseColor
                                            randomImage = imageArray.randomElement()!.content.1
                                            gotoArtView = true
                                            withTimer = true
                                        }.buttonStyle(ChooseButton())
                                 
                                    }
                                    HStack {
                                        Button(NSLocalizedString("hard", comment: "")) {
                                            playMode = PlayMode.reverseLines
                                            randomImage = imageArray.randomElement()!.content.0
                                            gotoArtView = true
                                            withTimer = true
                                        }.buttonStyle(ChooseButton())
                                  
                                    }
                                    Spacer()
                                    Button(NSLocalizedString("bonus1", comment: "")) {
                                        gotToMiniGame = true
                                    }.buttonStyle(ChooseButton(fillColor: Color("Color_orange")))
                                    Button(NSLocalizedString("bonus2", comment: "")) {
                                        gotoMiniGameLarge = true
                                    }.buttonStyle(ChooseButton(fillColor: Color("Color_orange")))
                                    Spacer()
                                    Group {
                                        Spacer()
                                        Spacer()
                                    }
                                    Button(NSLocalizedString("settings", comment: "")) {
                                        showSettings = true
                                    }.buttonStyle(ChooseButton())
                                }
                                Spacer()
                                
                            }
                            
                        } .foregroundColor(foreC)
                            .overlay(
                                Button(action: {
                                    goToSelectionView = true
                                }) {
                                    Text(NSLocalizedString("mainMenu", comment: ""))
                                        .font(.title2)
                                        .padding()
                                        .foregroundColor(Color("Background"))
                                        .background(Color("Color_marker"))
                                        .border(foreC)
                                }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading),
                                alignment: .topTrailing
                            )
                    } // e2. lse
                } //ZStack
            } // geometry
        } // 1. else
    } // body
} // View



