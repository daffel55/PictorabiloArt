//
//  BonusGameModel.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 04.06.23.
//MARK: NEU

import Foundation
//import SwiftUI
/// model for  bonus games , where the user has to match artist an cards
struct BonusGameModel {
    var randomPicture = Picture(name: "unknown", artist: "unknown",id: 45,  matched: false) // placeholder value
    var randomArtist = ""
    var gameWon : Bool = false
    var gameOver = false
    var pictures : [Picture]
    var chosenArtist = ""
    var correctArtist = false
    let possibleTries = 3
    var currentTries = 0
    var lostTry = false
    var playSoundOhNo = false
   /// creates picures (array of Picture
    init() {
        var pics : [Picture] = []
        for i in 0...24 {
            pics.append(Picture(name: arrayOfPics[i].0, artist: arrayOfPics[i].1, id: i, matched: false))
        }
        self.pictures = pics
        
    }
    mutating func generateNewRandomArtist() {
        //  to prevent an endless loop, the loop,
        // that picks a new random picture, can only
        // run if not all are matched, it then looks for
        // a rondom card that is not matched
        let gotoLoop = !allAreMatched()
        if gotoLoop {
            repeat {
                randomPicture = pictures.randomElement()!
            } while randomPicture.matched
        }
        randomArtist = randomPicture.artist
    }
    
    mutating func allAreMatched() -> Bool {
        for pic in pictures {
            if !pic.matched {
                return false
            }
        }
        return true
    }
    /// compares the artist that belongs to the given picturel with the randomArtist
    /// if they are equal it triggers  allAreMatched() and generateNewRandomArtist()
    /// else it sets the gameOver-flag
    mutating func processTap(pic : Picture) {
        if let chosenIndex = pictures.firstIndex(where: {$0.id == pic.id}) {
            chosenArtist = pictures[chosenIndex].artist
            lostTry = false
            playSoundOhNo = false
            if chosenArtist == randomPicture.artist {
                pictures[chosenIndex].matched = true
                gameWon = allAreMatched()
                generateNewRandomArtist()
            } else {
                playSoundOhNo = true
                currentTries += 1
                if currentTries >= possibleTries {
                    gameOver = true
                }
                else {
                    lostTry = true // is used to trigger change of text that shows user how many tries there are
                }
            }
        }
  
    }
    
 /// detail picture that is shown to the user and should be matched by him to the artist name presented
    struct Picture {
        var name : String
        var artist : String
        var id : Int
        var matched : Bool
        }
}


