//
//  GridOfArt.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 18.05.23.
//

import SwiftUI

struct GridOfArt : View {

    @Binding var picture : PictureMadeOfCards
    @Binding var game : ArtModel
    @Binding var imageArray :  [Card]
    @Binding var showJoker : Bool
    @Binding var showBigger : Bool
    @Binding var tappable : Bool
    @Binding var biggerImage : String
    @Binding var playmode : PlayMode
    @Binding var useSound : Bool
    @Binding var correctPictCount : Int
    @Binding var hasJoker : Bool
    let defaults = UserDefaults.standard
    @Binding var madeMistake : Bool
    @Binding var numberOfJokersLeft : Int
    @Binding var showNextButton : Bool
    @Binding var idArr : [Int]
    @Binding var currentClickedImage : String
    var body: some View {
        VStack(spacing: 2){
            ForEach(0..<5) {row in
                HStack(spacing: 2){
                    ForEach(0 ..< 5) { col in
                        Image(displayPicture(for: imageArray[row*5+col]))
                            .resizable()
                            .scaledToFit()
                            .overlay(content: {
                                if imageArray[row*5+col].wrongPic {
                                    ZStack {
                                        Color.white.opacity(0.7)
                                        Text("Oh no!").font(.title2)
                                            .foregroundColor(backC)
                                    }
                                }
                            })
                            .onTapGesture {
                                currentClickedImage = displayPictureForMisstakeView(for: imageArray[row*5+col])
                                print("bin in TapGesture")
                                print("tappale: \(tappable)")
                                if showJoker || showBigger {
                                    showJoker = false
                                    showBigger = false
                                    tappable = true
                                }
                                
                                if tappable {
                                    
                                    showBigger = false
                                    correctPicture(i: row*5+col)
                                    print("Setze jetzt den Button auf enabled")
                                    print("ShowNext davor: \(showNextButton)")
                                    showNextButton = true
                                    print("ShowNext danach : \(showNextButton)")
                                    tappable = false
                                   
                                }
                            }
                            .onLongPressGesture(perform: {
                                tappable = false
                                biggerImage = getBiggerImage(card: imageArray[row*5+col])
                                showBigger = true
                            })
                    }
                }
            }
        }
    }
        func getBiggerImage(card : Card) -> String {
            switch playmode {
            case .standardLines, .reverseColor :
                return card.content.0
            case .standardColor, .reverseLines:
                return card.content.1
            }
        }
        func displayPicture(for card : Card) -> String {
            var str = ""
            switch playmode {
            case .standardLines:
                str = card.isMatched ? card.content.1 : card.content.0 //randomCard hierzu ist card.content.0
            case .standardColor:
                str = card.isMatched ? card.content.0 : card.content.1 //randomCard hierzu ist card.content.1
            case .reverseColor: //farbige Karte  gezeigt, Linienbild zum finden
                str = card.isMatched ? card.content.1 : card.content.0 //randomCard hierzu ist card.content.1
            case .reverseLines: //Linienkarte gezeigt, farbige Karte zum Suchen
                str = card.isMatched ? card.content.0 : card.content.1 //randomCard hierzu ist card.content.0
            }
            return str
        }
    
    func displayPictureForMisstakeView(for card: Card) -> String {
        var str = ""
        switch playmode {
        case .standardLines, .reverseLines:
            str = card.content.0
        case .standardColor,  .reverseColor:
            str = card.content.1
        }
        return str
    }
        func correctPicture(i : Int)  {
            print("bin in correctPicture")
            if game.clickedCorrectPic(i: i) {
                if useSound {
                    SoundManager.instance.playSound(sound: .swap, soundtype: .m4a)
                }
                if !hasJoker {
                    correctPictCount += 1
                }
                if correctPictCount == 5 {
                    hasJoker = true
                    correctPictCount = 0
                }
                if game.checkIfWon() {
                    if useSound {
                        SoundManager.instance.playSound(sound: .bell, soundtype: .mp3)
                    }
                    if !idArr.contains(picture.id) {
                        idArr.append(picture.id)
                    }
                    
                    defaults.set(idArr, forKey: "ids")
                    

                    
                }
            } else {
                if useSound {
                    SoundManager.instance.playSound(sound: .ohno, soundtype: .m4a)
                }
                madeMistake = true
                hasJoker = true
                correctPictCount = 5
                numberOfJokersLeft = 3
                
            }
            //showNextButton = true
            
        }
    }
