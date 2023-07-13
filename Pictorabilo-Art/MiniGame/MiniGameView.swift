//
//  MiniGameView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 28.04.23.
//

import SwiftUI
import AVFoundation



struct MiniGameView: View {
    @Binding var picture : PictureMadeOfCards
    //@Binding var arrayOfCardsForMini2 : [CardForMini]
    //@Binding var arrayOfCardsForMini2Large : [CardForMini]
    @State var game = MiniGameModel(cards: leyster.cardsMiniArtist)
    @Binding var goBack : Bool
    @State var originText = ""
    @State var numberOfChosenPics = 0
    @State var destinationText = ""
    @State var showSheet = false
    @State var showInfo = false
    @State var gotoMini2Large = false
    @AppStorage("useSound") var useSound = true
    
   
   
   
    
    var body: some View {
        GeometryReader { geo in
            if gotoMini2Large {
                MiniGameLarge(picture: $picture, goBack: $gotoMini2Large)
            } else {
                ZStack {
                    Color("Background").ignoresSafeArea()
                    VStack(alignment: .center, spacing: 0) {
                        HStack {
                            Button(NSLocalizedString("back", comment: "")) {
                                goBack = false
                            }
                            .padding(.bottom, 2)
                            .padding(.horizontal, 20)
                            .foregroundColor(backC)
                            
                            
                            Spacer()
                            Button(NSLocalizedString("more", comment: "")) {
                                gotoMini2Large = true
                            }.padding(.bottom, 2)
                                .padding(.horizontal, 20)
                                .foregroundColor(backC)
                            
                            
                            Button("INFO") {
                                showInfo = true
                            }
                            .padding(.bottom, 2)
                            .padding(.horizontal, 20)
                            .foregroundColor(backC)
                            
                        }.font(.system(size: 24))
                            .background(foreC)
                        
                        
                        HStack(spacing: 0) { // 1. HStack
                            ForEach(0 ..< 3) { i in
                                Image(game.cards[i].content)
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(game.cards[i].waitingToSwap ? 0.5 : 1)
                                    .onTapGesture {
                                        game.processTap(index: i)
                                        
                                    }
                            }
                        }
                        HStack(spacing: 0) { //2. HStack
                            ForEach(0 ..< 3) { i in
                                Image(game.cards[i + 3].content)
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(game.cards[i + 3].waitingToSwap ? 0.5 : 1)
                                    .onTapGesture {
                                        game.processTap(index: i + 3)
                                    }
                            }
                        }
                        HStack(spacing: 0) { // 3.HStack
                            ForEach(0 ..< 3) { i in
                                Image(game.cards[i + 6].content)
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(game.cards[i + 6].waitingToSwap ? 0.5 : 1)
                                    .onTapGesture {
                                        game.processTap(index: i + 6)
                                    }
                            }
                        }
                        if !game.gameWon {
                            VStack {
                                Button(action:{
                                    if useSound {
                                        SoundManager.instance.playSound(sound: .swap, soundtype: .m4a)
                                    }
                                    
                                    game.swapCards()
                                    game.checkForGameWon()
                                    if game.gameWon && useSound {
                                        SoundManager.instance.playSound(sound: .bell, soundtype: .mp3)
                                    }
                                    numberOfChosenPics = 0
                                    originText = ""
                                    destinationText = ""
                                   
                                },label:  {
                                    HStack {
                                        Image(systemName: "rectangle.2.swap")
                                            .font(.largeTitle)
                                        
                                    }.font(.title)
                                        .padding(.top, 10)
                                        .frame(width: geo.size.width)
                                        .foregroundColor(backC)
                                        .background(foreC)
                                    
                                })
                            }.padding(.horizontal)
                            
                            
                            
                        }
                        
                        
                        
                    }//VStack
                    .frame(width: geo.size.width)
                } //Zstack
                .sheet(isPresented: $showInfo, content: {
                    VStack(spacing: 40) {
                        Text(NSLocalizedString("chaos", comment: ""))
                       Text(NSLocalizedString("infoMiniGame", comment: "Minigame explained"))
                        Button("OKAY") {
                            showInfo = false
                        }
                        
                    }.font(.title).multilineTextAlignment(.leading).padding(.horizontal, 40)
                    
                })
                
                .onAppear(perform: {
                    game = MiniGameModel(cards: picture.miniArray)
                })
            } //else
    }// end geometry
    }//body
    
    
      
        
} // view

