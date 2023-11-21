//
//  SoundManager.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 25.05.23.
//

import Foundation
import AVFoundation

var player : AVAudioPlayer?

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
