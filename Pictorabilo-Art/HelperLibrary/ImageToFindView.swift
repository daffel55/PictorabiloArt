//
//  ImageToFindView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 08.07.23.
//MARK: NEU

import SwiftUI
/// a View that is presented in ArtGame if showImgeToFind is true,
/// it holds the DetailCardView and the next button
/// it also sets the timer if withTimer is true
struct ImageToFindView: View {
    
    @Binding var game : ArtGameModel
    @Binding var playmode : PlayMode
    @Binding var showImageToFind : Bool
    //steuert den Timer
    @State private var timeRemaining = 5.0 // onAppear set to the timeInterval that is stored in Appstorage
    @State var timeIsUp = false
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect() //that thing ticks always, sends a signal every 0.25 sec
    @AppStorage("timeInterval") var timeInterval = 5.0
    @AppStorage("withTimer") var withTimer = true
    // this is used to set the stored backgroundColor
    var colordata = ColorData()
    @State var gameColor = Color.darkStandard
    
    var body: some View {
        
            GeometryReader { geo in
                ZStack{
                    gameColor.ignoresSafeArea()
                    VStack{
                        DetailCardView(game: $game, playmode: $playmode, geo: geo)
                        Spacer()
                        NextButton(buttonAction: {
                            showImageToFind = false
                        }, text: NSLocalizedString("next", comment: ""), withImage: true).padding(.top, 95)
                    }
                }.onAppear(perform: {
                    timeRemaining = timeInterval
                    game.chooseRandomImage()
                    gameColor = colordata.loadColor()
                })
                .onReceive(timer)  { time in
                    if withTimer {
                        if timeRemaining > 0.0 {
                            timeRemaining -= 0.25
                        } else {
                            timeIsUp = true
                        }
                    }
                }
                .onChange(of: timeIsUp) { newValue in
                                if newValue == true {
                                   showImageToFind = false
                                }
                            }
            }
        }
    
}

