//
//  ArtModel.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 16.05.23.
//

import Foundation


struct ArtModel {
    var imageArray : [Card]
    var randomCard : Card
    var randomImage : String {
        get {
            (playmode == .standardLines || playmode == .reverseLines) ? randomCard.content.0 : randomCard.content.1
        }
    }
    var playmode : PlayMode
    var withTimer = false //brauche ich das?
    var gameWon = false
    
  
    mutating func clickedCorrectPic(i : Int)  -> Bool {
  
        let linesInDetail : Bool = (playmode == .standardLines || playmode == .reverseLines)
        
        var nameToCompare : String {
            linesInDetail ? imageArray[i].content.0 : imageArray[i].content.1
        }

        if nameToCompare == randomImage {
            imageArray[i].isMatched = true
            chooseNewRandomImage()
            return true
        } else {
            imageArray[i].wrongPic = true
            for index in imageArray.indices {
                imageArray[index].isMatched = false
            }
            chooseNewRandomImage()
            return false
        }
    }
    
    mutating func chooseNewRandomImage() {
        var goIntoRepeatLoop = false
        for index in imageArray.indices {
            if imageArray[index].isMatched == false {
                goIntoRepeatLoop = true
            }
        }
        if goIntoRepeatLoop {
            repeat {
                randomCard = imageArray.randomElement()!
                
            } while (randomCard.isMatched == true)
        } else {
            gameWon = true
            
           
        }
    }
    
    func checkIfWon() -> Bool {
        for img in imageArray {
            if !img.isMatched {
                return false
            }
        }
        return true
    }

    
    mutating func resetGame() {
        gameWon = false
        for index in imageArray.indices {
            imageArray[index].isMatched = false
            imageArray[index].wrongPic = false
        }
    }
    
}

struct Card: Identifiable {
    var isMatched: Bool = false
    var content: (String, String)
    var id = UUID()
    var wrongPic = false
    
}
