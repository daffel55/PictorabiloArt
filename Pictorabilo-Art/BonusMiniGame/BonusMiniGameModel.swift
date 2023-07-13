//
//  BonusMiniGameModel.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 27.04.23.
//

import Foundation
import SwiftUI

struct BonusMiniGameModel {
    var randomPicture = Picture(name: "unknown", artist: "unknown",id: 45,  matched: false)
    var randomArtist = ""
    var gameWon = false
    var gameOver = false
    var pictures : [Picture]
    var chosenArtist = ""
    var correctArtist = false
    let possibleTries = 3
    var currentTries = 0
    var lostTry = false
    var playSoundOhNo = false
   
    init() {
        
        var pics : [Picture] = []
        for i in 0...24 {
            pics.append(Picture(name: arrayOfPics[i].0, artist: arrayOfPics[i].1, id: i, matched: false))
        }
        self.pictures = pics
    }
    mutating func generateNewRandomArtist() {
        var gotoLoop = false
        for pic in pictures {
            if !pic.matched {
                gotoLoop = true
            }
        }
        if gotoLoop {
            repeat {
                randomPicture = pictures.randomElement()!
            } while randomPicture.matched
        } else {
           gameWon = true
        }
        
        randomArtist = randomPicture.artist
        
    }
    mutating func correctPic(pic : Picture) {
        
        if let chosenIndex = pictures.firstIndex(where: {$0.id == pic.id}) {
            chosenArtist = pictures[chosenIndex].artist
            lostTry = false
            playSoundOhNo = false
            if chosenArtist == randomPicture.artist {
                pictures[chosenIndex].matched = true
                
                generateNewRandomArtist()
            } else {
                playSoundOhNo = true
                currentTries += 1
                if currentTries >= possibleTries {
                    gameOver = true
                }
                else {
                    lostTry = true
                }
            }
        }
  
    }
    
 
    struct Picture {
        var name : String
        var artist : String
        var id : Int
        var matched : Bool
        }
}

