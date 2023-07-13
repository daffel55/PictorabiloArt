//
//  MiniGameModel.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 28.04.23.
//

import SwiftUI
struct MiniGameModel {
var gameWon = false
   
    var cards : [CardForMini]
    
    mutating func processTap(index: Int) {
       
        if cards[index].waitingToSwap {
            cards[index].waitingToSwap = false
            cards[index].indexToLog = ""
        } else {
            if numberOfWaitingCards() < 2 {
                cards[index].waitingToSwap = true
                cards[index].indexToLog = String(index + 1)
            }
            else if numberOfWaitingCards() >= 2 &&   cards[index].waitingToSwap {
                
                cards[index].waitingToSwap = false
                cards[index].indexToLog = ""
            }
        }
       
       
    }
    
    func numberOfWaitingCards() -> Int {
        var i = 0
        for card in cards {
            if card.waitingToSwap {
                i += 1
            }
        }
        return i
    }
    
    
    mutating func swapCards() {
        if let origin = Int(getTheIndicesToSwap().0) , let destination = Int(getTheIndicesToSwap().1) {
            if validateNumbers(origin: origin, destination: destination) {
                cards.swapAt(origin - 1, destination - 1)
                for index in cards.indices {
                    if cards[index].correctPlace == index + 1 {
                        cards[index].matched = true
                    } else {
                        cards[index].matched = false
                    }
                    cards[index].waitingToSwap = false
                    cards[index].indexToLog = ""
                    
                }
            }
        }
    }
    
    func validateNumbers(origin: Int, destination: Int) -> Bool {
        origin > 0 && origin <= 25 && destination > 0 && destination <= 25
    }
    
    mutating func checkForGameWon() {
        gameWon = true
        for card in cards {
            if card.matched == false {
                gameWon = false
            }
        }
    }
    
    func getTheIndicesToSwap() -> (String, String) {
        var theStrings = ("","")
        for card in cards {
            if card.indexToLog != "" {
                if theStrings.0 == "" {
                    theStrings.0 = card.indexToLog
                } else {
                    theStrings.1 = card.indexToLog
                }
            }
        }
        return theStrings
    }
    
   
}
