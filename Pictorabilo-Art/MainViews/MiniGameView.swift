//
//  MiniGameView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 02.06.23.
//MARK: NEU


import SwiftUI
import AVFoundation



struct MiniGameView: View {
    // @Binding var picture : PictureMadeOfCards
    @State var picture : PictureMadeOfCards
    @State var miniGame = MiniGameModel(cards: leyster.cardsMiniArtist)
    @Binding var goBack : Bool
    @Binding var user : UserData
    @State var showSheet = false
    @State var showInfo = false
    @State var gotoMini2Large = false
   
    var colordata = ColorData()
    @AppStorage("useSound") var useSound = true
    
    var body: some View {
        GeometryReader { geo in
           
                ZStack {
                    Color.darkStandard.ignoresSafeArea()
                    VStack(alignment: .center, spacing: 0) {
                        
                        HStack {
                          
                        
                            
                            
                            Spacer()
                            
                            
                           
                            
                        }.font(.system(size: 24))
                            .background(Color.lightStandard)
                        
                        VStack(spacing: 2){
                            ForEach(0..<3) {row in
                                HStack(spacing: 2){
                                    ForEach(0 ..< 3) { col in
                                        Image(miniGame.cards[row*3+col].content)
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(miniGame.cards[row*3+col].waitingToSwap ? 0.5 : 1)
                                            .onTapGesture {
                                                miniGame.processTap(index: row*3+col)
                                                
                                            }
                                    }
                                }
                            }
                        }
                        
                        if !miniGame.gameWon {
//                            HStack {
//                                Button( action:
//                                    {
//                                    goBack = false
//                                }) {
//                                    Image(systemName: GameConstants.backImage)
//                                }
//                                .padding(.bottom, 2)
//                                .padding(.horizontal, 20)
//                                .foregroundColor(.darkStandard)
//                                Button(action:{
//                                    swapButtonAction()
//                                },label:  {
//                                    HStack {
//                                        Image(systemName: "rectangle.2.swap")
//                                            .font(.largeTitle)
//
//                                    }.font(.title)
//                                        .padding(.top, 10)
//                                        //.frame(width: geo.size.width)
//                                        .foregroundColor(.darkStandard)
//                                        .background(Color.lightStandard)
//
//                                })
//                                Button(action:{
//                                    showInfo = true
//                                }) {
//                                    Image(systemName: GameConstants.infoImage)
//                                }
//
//                                 .padding(.bottom, 2)
//                                 .padding(.horizontal, 20)
//                                 .foregroundColor(.darkStandard)
//                            }.padding(.horizontal)
//                                .frame(width: geo.size.width)
                            BottomButton(numberOfButton: 3, buttonActions:[
                                {
                                    goBack = false
                                
                                }, {swapButtonAction()}, {showInfo = true}], imageNames: ["arrowshape.turn.up.left", "rectangle.2.swap", "info.circle"], texts: ["","",""])
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
                    miniGame = MiniGameModel(cards: picture.miniArray)
                })
        //else
        }// end geometry
    }//body
    
    
    func swapButtonAction() {
        if useSound {
            SoundManager.instance.playSound(sound: .swap, soundtype: .m4a)
        }
        miniGame.swapCards()
        miniGame.checkForGameWon()
        if miniGame.gameWon  {
            if useSound {
                SoundManager.instance.playSound(sound: .bell, soundtype: .mp3)
            }
            user.playedDict[picture.id]?.append("bonus1")
            user.encodeUserData(user: user)
        }
        
    }
} // view

