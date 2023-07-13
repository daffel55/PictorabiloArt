//
//  Utilities.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 07.04.23.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation
var player : AVAudioPlayer?


struct PictureMadeOfCards: Identifiable {
    var cards : [Card]
    var selctionImageName : String
    var painter : String
    var pictureName : String
    var painterText : String
    var miniArray: [CardForMini]
    var miniArrayLarge : [CardForMini]
    var id : Int
}

func isInLandscape(geoWidth : Double, geoHeight : Double) -> Bool {
    if geoWidth > geoHeight {
        
        return true
    }
    return false
}

//is changing card's width depending on orientaton
func getAdpatedWidth(size : CGSize) -> Double {
    if isInLandscape(geoWidth: size.width, geoHeight: size.height) {
        return size.width / 12.5
    }
    return size.width / 7.0
}

var helpButtonText = ""


enum PlayMode {
    case standardLines
    case standardColor
    case reverseColor
    case reverseLines
}


struct ChooseButton : ButtonStyle {
    var fillColor = foreC
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(fillColor)
            configuration.label
                .font(.largeTitle)
                .foregroundColor(backC)
                
        }.frame(width: 300, height: 80)
    }
}
struct ChooseButtonSmaler : ButtonStyle {
    var fillColor = Color("Color_orange")
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(fillColor)
            configuration.label
                .font(.title2)
                .foregroundColor(Color("DarkBackground"))
                
        }.frame(width: 300, height: 40)
    }
}


struct BackButton : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(foreC)
            configuration.label
                .font(.title2)
                .foregroundColor(backC)
                
        }.frame(width: 100, height: 30).border(.black, width: 2)
    }
}




struct CardForMini {
    var content : String
    var correctPlace : Int
    var matched = false
    var waitingToSwap = false
    var indexToLog = ""
   
    
}


class SoundManager {
    static let instance = SoundManager()
    
    enum SoundOption: String {
        case swap
        case ohno
        case bell
        case noSound
        
    }
    
    enum SoundTypeOption : String {
        case m4a
        case wav
        case mp3
    }
    func playSound(sound: SoundOption, soundtype: SoundTypeOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: soundtype.rawValue) else {return}
        do {
            player =  try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
        
    }
}
