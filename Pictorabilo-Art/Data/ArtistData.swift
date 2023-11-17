//
//  ArtistData.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 09.05.23.
//

import Foundation


class ArtistData {
    
    var artistName : String // der Nachname klein geschrieben z.B. "wood"
    // Array mit den Einzelbildern, Linien und Farbe
    var fullNameOfPainter : String // der volle Name des Malers z.B. "Grant Wood"
    var nameOfPicture : String //Name des Bildes z.B. "American Gothic"
    
    //macht ein Array aus Tupeln mit den Namen der Detailbildern, sollte es mehr als ein Bild pro Maler geben, wird das nächste unter Name_des_Malers2 etc geführt
    var artistDetailPics : [(String, String)] {
        (1...25).map { ("\(artistName)_Linien\($0)", "\(artistName)_Farbe\($0)") }
        
    }
    
    var selectionImageName : String { "\(artistName)SelectPic" }//Name des Bildes für SelectionView
    
    //macht aus den detailBildern ein Card-Array
    var artistCards : [Card] {
        makeCardArray(artistDetailPics: artistDetailPics)
     }

    //Bildausschnitt für das Minigame, postitions wird in der Init aus der ersten Position errechnet
    var positions : [Int]
     var cardsMiniArtist : [CardForMini] {
         makeCardArrayForMini(artistDetailPics: artistDetailPics, positions: positions)
     }
     //Bild für das MinigameLarge, sind im Prinzip einfach alle Bilder, braucht aber CardForMini als Datentyp
    var cardsMiniLargeArtist : [CardForMini] {
        get {
            makeCardArrayForMiniLarge(artistDetailPics: artistDetailPics)
        }
    }
    // Der Text in der Infobox
    var artistText : String

    init(artistname: String, fullNameOfPainter : String, nameOfPicture : String, startPosition: Int, artistText : String){
        self.artistName = artistname
        self.fullNameOfPainter = fullNameOfPainter
        self.nameOfPicture = nameOfPicture
        self.positions = [startPosition, startPosition + 1, startPosition + 2, startPosition + 5,  startPosition + 6, startPosition + 7, startPosition + 10, startPosition + 11, startPosition + 12]
        self.artistText = artistText
    }
    
    
    // macht aus einem Array mit einem Stringtupel ein Card-Array
    func makeCardArray(artistDetailPics : [(String, String)]) -> [Card] {
        var arr : [Card] = []
        for index in artistDetailPics.indices {
            arr.append(Card(content: artistDetailPics[index]))
        }
        return arr
    }
    //macht ein CardForMini-Array für MiniGame
    func makeCardArrayForMini(artistDetailPics: [(String, String)], positions: [Int] ) ->  [CardForMini] {
        var arr : [CardForMini] = []
        var place = 1
        for index in positions.indices {
            arr.append(CardForMini(content: artistDetailPics[positions[index]].1, correctPlace: place))
            place += 1
        }
        return arr.shuffled()
    }

    // macht ein CardForMini-Array für MiniGameLarge
    func makeCardArrayForMiniLarge(artistDetailPics : [(String, String)]) -> [CardForMini] {
        var arr : [CardForMini] = []
        for index in artistDetailPics.indices {
            arr.append(CardForMini(content: artistDetailPics[index].1, correctPlace: index + 1))
        }
        return arr.shuffled()
    }
    


}
// Alle Info-texte
var holbeinText = NSLocalizedString("holbein", comment: "Details about Holbein")
var leysterText = NSLocalizedString("leyster", comment: "Details about Leyster")
var jakuchuText = NSLocalizedString("jakuchu", comment: "Details about Jakuchu")
var woodText = NSLocalizedString("wood", comment: "Details about Wood")
var kleeText = NSLocalizedString("klee", comment: "Details about Klee")
var klimtText = NSLocalizedString("klimt", comment: "Details about Klimt")
var merianText = NSLocalizedString("merian", comment: "Details about Merian")
var rousseauText = NSLocalizedString("rousseau", comment: "Details about Rousseau")
var michelangeloText = NSLocalizedString("michelangelo", comment: "Details about Michelangelo")
var brueghelText = NSLocalizedString("brueghel", comment: "Details about Brueghel")
var friedrichText = NSLocalizedString("friedrich", comment: "Details about Friedrich")
var baluschekText = NSLocalizedString("baluschek", comment: "Details about Baluschek")
var kandinskyText = NSLocalizedString("kandinsky", comment: "Details about Kandinsky")
var hokusaiText = NSLocalizedString("hokusai", comment: "Details about Hokusai")
var spitzwegText = NSLocalizedString("spitzweg", comment: "Details about pitzweg")
var delaunay2Text = NSLocalizedString("delaunay2", comment: "Details about Delaunay")

var holbeinPicName = NSLocalizedString("holbeinPicName", comment: "")
var leysterPicName = NSLocalizedString("leysterPicName", comment: "")
var jakuchuPicName = NSLocalizedString("jakuchuPicName", comment: "")
var woodPicName = NSLocalizedString("woodPicName", comment: "")
var kleePicName = NSLocalizedString("kleePicName", comment: "")
var klimtPicName = NSLocalizedString("klimtPicName", comment: "")
var merianPicName = NSLocalizedString("merianPicName", comment: "")
var rousseauPicName = NSLocalizedString("rousseauPicName", comment: "")
var michelangeloPicName = NSLocalizedString("michelangeloPicName", comment: "")
var brueghelPicName = NSLocalizedString("brueghelPicName", comment: "")
var friedrichPicName = NSLocalizedString("friedrichPicName", comment: "")
var baluschekPicName = NSLocalizedString("baluschekPicName", comment: "")
var kandinskyPicName = NSLocalizedString("kandinskyPicName", comment: "")
var hokusaiPicName = NSLocalizedString("hokusaiPicName", comment: "")
var spitzwegPicName = NSLocalizedString("spitzwegPicName", comment: "")
var delaunayPicName = NSLocalizedString("delaunay2PicName", comment: "")
