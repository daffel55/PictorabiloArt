//
//  ArtGameModel.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 21.05.23.
//MARK: NEU

import Foundation
///  holds the structure of the game
struct ArtGameModel {
    var picture : PictureMadeOfCards
    var randomCard = woodPicture.cards[0] // placeholder value, the card to look for
    var wrongCard = woodPicture.cards[1] //placeholder value, holds the card that was mismatched to show it to the user
    var madeMistake = false
    // the amount of correct choices the user must make to gain a new joker is 5,
    // this is set to 5 and get +=1 with every correct click, only if user takes
    // a joker it is set to 0, and the next joker is ready when it reaches 5 again
    var correctPicCount = 5
    var numberOfJoker : Int = GameConstants.maxJoker // 3
    var hasJoker = true // get the first joker from the start
    
    /// compares the clicked card with the one that ought to be found and sets accordingly the flag .isMatched to the card
    mutating func clickedOnCard(cardIndex : Int)  {
        if picture.cards[cardIndex].id == randomCard.id {
            for index in picture.cards.indices {
                if index == cardIndex {
                    picture.cards[index].isMatched = true
                }
            }
            correctPicCount += 1 // on the way to a new joker
        } else {
            picture.cards[cardIndex].wrongPic = true
            madeMistake = true
            for index in picture.cards.indices {
                picture.cards[index].isMatched = false
            }
        }
    }
    /// chooses a new randomCard without taking one that was already shown
    mutating func chooseRandomImage()  {
        if !allAreMatched() {
            repeat {
                randomCard = picture.cards.randomElement()!
                
            } while (randomCard.isMatched == true)
        }
    }
    /// is true when game is won
    func allAreMatched() -> Bool {
        for card in picture.cards {
            if !card.isMatched {
                return false
            }
        }
        return true
    }
    /// removes the wrongPic flag from all cards, used when next button is hit after mistake
    /// if there was no wrongPic no harm is done, else wrongPic is removed
    mutating func resetWrongPics() {
        for index in picture.cards.indices {
            picture.cards[index].wrongPic = false
        }
    }
    
    mutating func resetGame() {
        numberOfJoker = GameConstants.maxJoker
        correctPicCount = 0
        for index in picture.cards.indices {
            picture.cards[index].isMatched = false
            picture.cards[index].wrongPic = false
        }
    }
    /// after checking if joker is available it subtracts 1 from numberOfJoker
    /// if last joker was used it sets hasJoker to false
    mutating func takeJoker() {
        if correctPicCount >= 5 && hasJoker {
            numberOfJoker -= 1
            correctPicCount = 0 // now it takes 5 correct clicks to get a new joker
        }
        if numberOfJoker <= 0 {
            hasJoker = false
        }
    }
    /// if there is a card with the worngPic-flg it is stored in the variable wrongCard to be shown to the user
    mutating func setWrongCard() {
        for index in picture.cards.indices {
            if picture.cards[index].wrongPic {
                wrongCard = picture.cards[index]
            }
        }
    }
}// end ArtGameModel






