//
//  ArtView25x25.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 22.05.23.
//

import SwiftUI
/// a View that display the picture made out of 25 detail cards
/// Paramater: game: ArtGameModel,
/// @BInding playmode: Playmode (determines whether the picture is colored or not
/// @Binding control: GameControl
/// geo: GeometryProxy (that comes from parent view (ArtGame)
/// showBigger: Bool to display a magnified image from tapped card
/// nameOfImageToZoom : String to hold the name of the card that should be magnified
struct ArtView5x5: View {
    @Binding var game: ArtGameModel
    @Binding var playmode : PlayMode
    @Binding var control : GameViewControl
    var geo : GeometryProxy
    @State var showBigger = false
    @State var nameOfImageToZoom = ""
    @AppStorage("useSound") var useSound = true
    var body: some View {
        ZStack{
            VStack(spacing: 2){
                ForEach(0..<5) {row in
                    HStack(spacing: 2){
                        ForEach(0 ..< 5) { col in
                            Image(detailImage(i: row*5+col))
                                .resizable()
                                .scaledToFit()
                                .onTapGesture(perform: {
                                    tapAction(i: row*5+col)
                                })
                                .onLongPressGesture(perform: {
                                    nameOfImageToZoom = detailImage(i: row*5+col)
                                    if control.allowTap {
                                        showBigger = true
                                    }
                                    control.allowTap = false
                                })
                                .overlay(content: {
                                    game.picture.cards[row*5+col].wrongPic ? Color.white.opacity(0.7) : Color.clear
                                    // to give a visual feedback that this is the wrong card (if useSound true also a ohno-Sound is played
                                })
                        }
                    }.frame(width: geo.size.width)
                }
            }
            if showBigger {
                ShowBiggerImage(nameOfImageToZoom: $nameOfImageToZoom, control: $control, showBigger: $showBigger)
            }
            if game.madeMistake {
                ShowMistakeView(game: $game, playMode: $playmode)
            }
        }
    }
    
        
    func detailImage(i : Int) -> String {
        switch playmode {
        case .standardLines, .reverseColor: return game.picture.cards[i].isMatched ? game.picture.cards[i].content.1 : game.picture.cards[i].content.0
        case .standardColor, .reverseLines : return game.picture.cards[i].isMatched ? game.picture.cards[i].content.0 : game.picture.cards[i].content.1
        default: return ""
        }
    }
    func tapAction(i : Int) {
        if control.allowTap && !game.picture.cards[i].isMatched {
            control.allowTap = false
            control.disableNext = false
            game.clickedOnCard(cardIndex: i)
            if useSound {
                if !game.picture.cards[i].wrongPic {
                    SoundManager.instance.playSound(sound: .swap, soundtype: .m4a)
                } else {
                    SoundManager.instance.playSound(sound: .ohno, soundtype: .m4a)
                    game.setWrongCard()
                    game.numberOfJoker = 3
                    game.hasJoker = true
                    game.correctPicCount = 5
                }
                if game.allAreMatched() {
                    SoundManager.instance.playSound(sound: .bell, soundtype: .mp3)
                    
                }
            }
        }
    }
    
    
    
}

