//
//  MainMenuView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 23.05.23.
//MARK: NEU
// MARK: Das Menu mit den einzelnen Bildern
import SwiftUI

struct MainMenuView: View {
    @State var gotoArtGame = false
    
    let defaults = UserDefaults.standard
    @State var game = ArtGameModel(picture: woodPicture) //sample value, gets overwritten when user clicks on choosePictureToPlayView
    @State var user : UserData = UserData()
    @State var playmode : PlayMode = .standardLines
    @State var showInstructionView = false
    @State var gotoBonusGame = false
    @State var showSettings = false
    @State var showImageToFind = true
   
    
    var body: some View {
        GeometryReader { geo in
            
            if gotoBonusGame {
                BonusGameView(gotoBonusGame: $gotoBonusGame)
            }
           
            
            else if gotoArtGame {
                if user.playedPictures.contains(game.picture.id) {
                    SecondMenuView(game: $game, user: $user)
                } else {
                    ArtGame(user: $user, gotoArtGame: $gotoArtGame, playmode: $playmode,  game: game)
                }
            } else {
                GeometryReader { geo in
                    ZStack(alignment: .center) {
                        Color.darkStandard.ignoresSafeArea()
                        
                        VStack(spacing: 15){
                            //                        #if DEBUG
                            //                        Button("reset") {
                            //                            user.resetUserData()
                            //                        }.foregroundColor(.lightGreen)
                            //                        Button("Fill all") {
                            //                            user.setAllPicturesToPlayed()
                            //                        }.foregroundColor(.marker)
                            //                        #endif
                            ChoosePictureToPlayView(game: $game, gotoArtGame: $gotoArtGame, geo: geo, user: $user, gotoBonusGame: $gotoBonusGame)
                            BottomButton(numberOfButton: 2, buttonActions: [
                                {
                                    showSettings = true
                                },
                                {
                                    showInstructionView = true
                                }], imageNames: ["gearshape", "info.circle"] , texts:  isIPad ? [GameConstants.settingsText,GameConstants.instructText] : ["",""]  )
                        }
                        if showInstructionView {
                            InstructionView(showInstructionView: $showInstructionView)
                        }
                        if showSettings {
                            ZStack {
                                SettingsView(showSettings: $showSettings, geo: geo)
                            }
                           
                                      
                       }
                    } //ZStack
                    .onAppear(perform: {
                        //user = UserData()
                        user = user.decoderUserData()
                    })
                     
                        

                } //geometryreader
            } // else
        }
    }
}


