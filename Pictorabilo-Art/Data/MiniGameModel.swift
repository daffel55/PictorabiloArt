//
//  MiniGameModel.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 02.06.23.
//MARK: NEU

import Foundation

struct MiniGameModel {
var gameWon = false
   
    var cards : [CardForMini]
    /// set exactly two cards in a sort of locked state (waitingToSwap) and logs their indices
    mutating func processTap(index: Int) {
        // unlock card that was locked before
        if cards[index].waitingToSwap {
            cards[index].waitingToSwap = false
            cards[index].indexToLog = ""
        } else { // clikc on a card that is unlocked
            // if this card is first oder second card (there is another locked card or no other locked card
            // this card is locked (waitingToSwap) and ist index is saved
            // ´warum ist die String Umwandlung notwendig? Um das Problem mit Index 0 zu umgehen?
            if numberOfWaitingCards() < 2 {
                cards[index].waitingToSwap = true
                cards[index].indexToLog = String(index + 1) // places are index + 1
            }
            // if there are two cards locked or the user clicked on a locked card
            // the card that was clicked is not locked (that doesnt interfer with different
            // cards theat are locked, to unlock them you should click on them
            // idea: the game must know which of the locked cards shpuld be changed in first unlocking it
            else if numberOfWaitingCards() >= 2 && cards[index].waitingToSwap {
                cards[index].waitingToSwap = false
                cards[index].indexToLog = ""
            }
        }
    }
    /// goes to the array and finds all cards with waitingToSwap true, returns the count of these cards
    func numberOfWaitingCards() -> Int {
        var i = 0
        for card in cards {
            if card.waitingToSwap {
                i += 1
            }
        }
        return i
    }
    /// finds the two cards marked by the mehtod processTap and returns them as tuple of String
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
    
    /// swaps places of the two locked cards and checks if one or both are on the correct place, if a card is moved
    /// away from it's correct place, it looses the correctPlace flag
    /// finally all cards are unlocked again and there is no indexToLog
    mutating func swapCards() {
        if let origin = Int(getTheIndicesToSwap().0) , let destination = Int(getTheIndicesToSwap().1) {
            if validateNumbers(origin: origin, destination: destination) {
                cards.swapAt(origin - 1, destination - 1) // places are index + 1
                for index in cards.indices {
                    if cards[index].correctPlace == index + 1 {
                        cards[index].isMatched = true
                    } else {
                        cards[index].isMatched = false
                    }
                    cards[index].waitingToSwap = false
                    cards[index].indexToLog = ""
                    
                }
            }
        }
    }
    
    /// prevent that by any chance a number is outside the array of cards
    func validateNumbers(origin: Int, destination: Int) -> Bool {
        origin > 0 && origin <= 25 && destination > 0 && destination <= 25
    }
    /// checks whether  all cards are on the correct places or not,
    /// if so, it sets gameWon to true
    mutating func checkForGameWon() {
        gameWon = true
        for card in cards {
            if card.isMatched == false {
                gameWon = false
            }
        }
    }
}
