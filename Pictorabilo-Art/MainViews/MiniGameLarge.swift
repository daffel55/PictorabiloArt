//
//  MiniGameLarge.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 02.06.23.
//MARK: NEU

import SwiftUI

struct MiniGameLarge: View  {
        @State var picture : PictureMadeOfCards
        //@Binding var arrayOfCardsForMini2Large : [CardForMini]
        @State var miniGame = MiniGameModel(cards: merian.cardsMiniLargeArtist)
        @Binding var goBack : Bool
        @Binding var user : UserData
        @State var showSheet = false
        @State var showInfo = false
        @AppStorage("useSound") var useSound = true
       
       
       
        
        var body: some View {
            GeometryReader { geo in
            ZStack {
                Color.darkStandard.ignoresSafeArea()
                VStack(alignment: .center, spacing: 0) {
                    HStack {
                        Button(NSLocalizedString("back", comment: "")) {
                            goBack = false
                        }
                        .padding(.bottom, 2)
                        .padding(.horizontal, 20)
                        .foregroundColor(.darkStandard)
                        
                       
                        Spacer()
                        
                        
                        Button("INFO") {
                            showInfo = true
                        }
                        .padding(.bottom, 2)
                        .padding(.horizontal, 20)
                        .foregroundColor(.darkStandard)

                    }.font(.system(size: 24))
                        .background(Color.lightStandard)
                    
                    
                    ForEach(0..<5) {row in
                        HStack(spacing: 0){
                            ForEach(0 ..< 5) { col in
                                Image(miniGame.cards[row*5+col].content)
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(miniGame.cards[row*5+col].waitingToSwap ? 0.5 : 1)
                                    .onTapGesture {
                                        miniGame.processTap(index: row*5+col)
                                        
                                    }
                            }
                        }
                    }
                    if !miniGame.gameWon {
                        VStack {
                            Button(action:{
                                if useSound {
                                    SoundManager.instance.playSound(sound: .swap, soundtype: .m4a)
                                }
                                miniGame.swapCards()
                                miniGame.checkForGameWon()
                                if miniGame.gameWon  {
                                    if useSound {
                                        SoundManager.instance.playSound(sound: .bell, soundtype: .mp3)
                                    }
                                    user.playedDict[picture.id]?.append("bonus2")
                                    user.encodeUserData(user: user)
                                }
                            },label:  {
                                HStack {
                                    Image(systemName: "rectangle.2.swap")
                                        .font(.largeTitle)
                                    
                                }.font(.title)
                                    .padding(.top, 10)
                                    .frame(width: geo.size.width)
                                    .foregroundColor(Color.darkStandard)
                                    .background(Color.lightStandard)
                                    
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
                miniGame = MiniGameModel(cards: picture.miniArrayLarge)
               
            })
        }// end geometry
        }//body
        
    
          
            
    } // view



