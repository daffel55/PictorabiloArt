//
//  ArtistData.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 09.05.23.
//MARK: NEU

import Foundation
/// Information about a picture and its painter, if there are more than one pictures
/// holds all information concerning the artist like name, description,
/// related images for the detail cards and image for MainMenu
/// creates arrays of Card to play with

class PictureData {
    var artist : Artist
    var imagePrefix : String
    var nameOfPicture : String //name of the picture like "American Gothic"
    var pictureText : String
    var selectionImageName : String { "\(imagePrefix)SelectPic" } // images for main view
    var artistDetailPics : [(String, String)] {
        (1...25).map { ("\(imagePrefix)_Linien\($0)", "\(imagePrefix)_Farbe\($0)") }
    } // takes the artist name to make an array of string tuples, that define the images (images in assets are alreadxnamed like this)
    var artistCards : [Card] {
        makeCardArray(artistDetailPics: artistDetailPics)
    } //takes the array above and makes an array of cards
    var positions : [Int] // first index for mini game (section of 3x3 detail pics that varies from pic to pic
    var picLink : String // Link to picture (mostly wikicommon
    /// computed property that holds the array of CardForMini for the 3x3 card mini game
    var cardsMiniArtist : [CardForMini] {
        makeCardArrayForMini(artistDetailPics: artistDetailPics, positions: positions)
    }
    /// array of CardForMini for the large 5x5 mini game
    var cardsMiniLargeArtist : [CardForMini] {
        makeCardArrayForMiniLarge(artistDetailPics: artistDetailPics)
    }
    
    /// creates in iniit beginning with index of startPosition a Int-Array that holds the indices for the smaller mini game
    init(artist: Artist,imagePrefix : String ,nameOfPicture : String, pictureText: String, startPosition: Int, picLink: String){
        self.artist = artist
        self.imagePrefix = imagePrefix
        self.nameOfPicture = nameOfPicture
        self.pictureText = pictureText
        self.positions = [startPosition, startPosition + 1, startPosition + 2, startPosition + 5,  startPosition + 6, startPosition + 7, startPosition + 10, startPosition + 11, startPosition + 12]
        self.picLink = picLink
    }
    /// takes tuple of strings (name of same pic  in lines and in color) and gives an array of Card
    func makeCardArray(artistDetailPics : [(String, String)]) -> [Card] {
        var arr : [Card] = []
        for index in artistDetailPics.indices {
            arr.append(Card(content: artistDetailPics[index]))
        }
        return arr
    }
    /// return an array of 9 CardForMini game, gets the right pic thrpugh their indices in posiition and
    /// gives them the postion in the 3x3 grid, that is to be found, through place number
    func makeCardArrayForMini(artistDetailPics: [(String, String)], positions: [Int] ) ->  [CardForMini] {
        var arr : [CardForMini] = []
        var place = 1
        for index in positions.indices {
            arr.append(CardForMini(content: artistDetailPics[positions[index]].1, correctPlace: place))
            place += 1
        }
        return arr.shuffled()
    }
    /// returns an array of 35 CardForMini, gives each Card a correctPlace (number is index plus 1), then  shuffels the array
    func makeCardArrayForMiniLarge(artistDetailPics : [(String, String)]) -> [CardForMini] {
        var arr : [CardForMini] = []
        for index in artistDetailPics.indices {
            arr.append(CardForMini(content: artistDetailPics[index].1, correctPlace: index + 1))
        }
        return arr.shuffled()
    }
} // end PictureData

/// the detail card that as an array forms the picture, the array is made by PictureData
struct Card: Identifiable {
    var isMatched: Bool = false
    var content: (String, String) // first string lines, second colors
    var id = UUID()
    var wrongPic = false
    /* wrongPic determines a single card that was mismatched,
     * as isMatched = false describes all cards that are waiting to be matched,
     * so isMatched = false is NOT mismatched but not clicked.
     * If a card is clicked correctly isMAtched changes to true,
     * the card stays in the game and is shown in it's desired color/lines
     * If the card is clicked wrongly, wrongPic get true and the game is over.
     */
}

/// the detail card that as an array forms the picture for both  mini games, the array is made by PictureData
struct CardForMini: Identifiable {
    var content : String
    var correctPlace : Int
    var isMatched = false
    var waitingToSwap = false
    var indexToLog = ""
    var id = UUID()
    /*
     * other than in regular game there is no wrongPic that ends the game,
     * you can swap until you give up or the game is finished
     * the game has to know whether all cards are matched
     * for this they have to know the right place for this card, which
     * is an Int (between 1..9 or 1..25, set in ArtistData)
     * there is a difference between the place in the array (which is logged in indexToLog
     * and can be changed by the swap method and the correct place, which should not be
     * confused with an index
     */
}
/// defines a picture made of detail cards with name of painter, description, name of picture
/// defines also the associated array for mini games
struct PictureMadeOfCards: Identifiable {
    var pictureData : PictureData
    var artistData : Artist
    var cards : [Card]
    var selectionImageName : String // hte image shown in MainMenu
    //var pictureName : String
    var miniArray: [CardForMini] // array of detailcards that starts with a certain number a
    var miniArrayLarge : [CardForMini] // array of  all detailcards
    var id : Int
    // the init fetches parameter out of the given artist struct
    init(pictureData: PictureData, id : Int) {
        self.pictureData = pictureData
        self.artistData = pictureData.artist
        self.cards = pictureData.artistCards
        self.selectionImageName = pictureData.selectionImageName
        //self.pictureName = pictureData.nameOfPicture
        self.miniArray = pictureData.cardsMiniArtist
        self.miniArrayLarge = pictureData.cardsMiniLargeArtist
        self.id = id    } // this id is needed for saving which pictures are already solved
}

