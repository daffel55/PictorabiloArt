//
//  MiniGameLarge.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 03.05.23.
//

import SwiftUI

struct MiniGameLarge: View  {
    @Binding var picture : PictureMadeOfCards
        //@Binding var arrayOfCardsForMini2Large : [CardForMini]
    @State var game = MiniGameModel(cards: merian.cardsMiniLargeArtist)
        @Binding var goBack : Bool
        @State var originText = ""
        @State var numberOfChosenPics = 0
        @State var destinationText = ""
        @State var showSheet = false
        @State var showInfo = false
        @AppStorage("useSound") var useSound = true
       
       
       
        
        var body: some View {
            GeometryReader { geo in
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
                        
                        
                        Button("INFO") {
                            showInfo = true
                        }
                        .padding(.bottom, 2)
                        .padding(.horizontal, 20)
                        .foregroundColor(backC)

                    }.font(.system(size: 24))
                        .background(foreC)
                    
                    
                    RowOfFive(faktor: 0, game: $game)
                    RowOfFive(faktor: 5, game: $game)
                    RowOfFive(faktor: 10, game: $game)
                    RowOfFive(faktor: 15, game: $game)
                    RowOfFive(faktor: 20, game: $game)
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
//                                numberOfChosenPics = 0
//                                originText = ""
//                                destinationText = ""
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
                game = MiniGameModel(cards: picture.miniArrayLarge)
               
            })
        }// end geometry
        }//body
        
    
          
            
    } // view

struct RowOfFive : View {
    var faktor : Int
    @Binding var game : MiniGameModel
    var body: some View {
       
            HStack(spacing: 0) { // 1. HStack .... 1...5
                ForEach(0 ..< 5) { i in
                    Image(game.cards[i + faktor].content)
                        .resizable()
                        .scaledToFit()
                        .opacity(game.cards[i + faktor].waitingToSwap ? 0.5 : 1)
                        .onTapGesture {
                            game.processTap(index: i + faktor)
                        }
                }
            }
        }
    }


