//
//  Artists.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 09.05.23.
//MARK: NEU

import Foundation
/**
 #alle Künstler werden erst als Artist angelegt
 #dann das jeweilige Bild als PictureData (mit Artist als Parameter)
 #schließlich das PictureMadeOfCards angelegt
 */

class Artist {
    var name: String // family name of painter in lowercase like 'wood'
    var fullName: String // full name of painter like "Grant Wood"
    var artistText : String
    var customWikiLink : String?
    
    init(name: String, fullName: String, artistText: String, customWikiLink: String? = nil) {
        self.name = name
        self.fullName = fullName
        self.artistText = artistText
        self.customWikiLink = customWikiLink
    }
    
    func getWikiLink(name : String?) -> String {
        var convertedNameOfPainter = ""
        if let link = customWikiLink {
            return link
        }
        else {
            convertedNameOfPainter = fullName
        }
        let nameArray = convertedNameOfPainter.components(separatedBy: " ")
        var link = "https://" + NSLocalizedString("country", comment: "") + ".wikipedia.org/wiki/"
        let nameToUse = nameArray.joined(separator: "_")
        link.append(contentsOf: nameToUse)
        return link
        
    }
}

// 0. Wood
var g_Wood = Artist(name: "Wood", fullName: "Grant Wood", artistText: woodText)
var wood = PictureData(artist: g_Wood, imagePrefix : "Wood", nameOfPicture: woodPicName, pictureText: woodPicText, startPosition: 1, picLink: woodPicLink)
var woodPicture = PictureMadeOfCards(pictureData: wood, id: 0)
// 1.Kandinsky
var w_Kandinsky = Artist(name: "Kandinsky", fullName: "Wassily Kandinsky", artistText: kandinskyText)
var kandinsky = PictureData(artist: w_Kandinsky, imagePrefix : "Kandinsky", nameOfPicture: kandinskyPicName, pictureText: kandinskyPicText, startPosition: 6, picLink: kandinskyPicLink)
var kandinskyPicture = PictureMadeOfCards(pictureData: kandinsky, id: 1)
// 2. Hokusai
var k_Hokusai = Artist(name: "Hokusai", fullName: "Katsushika Hokusai", artistText: hokusaiText, customWikiLink: hokusaiLink)
var hokusai = PictureData(artist: k_Hokusai,imagePrefix : "Hokusai", nameOfPicture: hokusaiPicName, pictureText: hokusaiPicText, startPosition: 0,  picLink: hokusaiPicLink)
var hokusaiPicture = PictureMadeOfCards(pictureData: hokusai, id: 2)
// 3. Brueghel
var p_Brueghel = Artist(name: "Brueghel", fullName: NSLocalizedString("brueghelName", comment: ""), artistText: brueghelText, customWikiLink: NSLocalizedString("brueghelLink", comment: ""))
var brueghel = PictureData(artist:p_Brueghel, imagePrefix : "Brueghel", nameOfPicture: brueghelPicName, pictureText: brueghelPicText, startPosition: 7, picLink: brueghelPicLink)
var brueghelPicture = PictureMadeOfCards(pictureData: brueghel, id: 3)
// 4.Rousseau
var h_Rousseau = Artist(name: "Rousseau", fullName: "Henri Rousseau", artistText: rousseauText)
var rousseau = PictureData(artist: h_Rousseau, imagePrefix : "Rousseau", nameOfPicture: rousseauPicName, pictureText: rousseauPicText, startPosition: 6, picLink: rousseauPicLink)
var rousseauPicture = PictureMadeOfCards(pictureData: rousseau, id: 4)
// 5. Michelangelo
var michealangelo_B = Artist(name: "Michelangelo", fullName: "Michelangelo", artistText: michelangeloText, customWikiLink: NSLocalizedString("michelangeloLink", comment: ""))
var michelangelo = PictureData(artist: michealangelo_B, imagePrefix : "Michelangelo", nameOfPicture: michelangeloPicName, pictureText: michelangeloPicText, startPosition: 6, picLink: michelangeloPicLink)
var michelangeloPicture = PictureMadeOfCards(pictureData: michelangelo, id: 5)
// 6. Friedrich
var c_d_Friedrich = Artist(name: "Friedrich", fullName: "Caspar David Friedrich", artistText: friedrichText)
var friedrich = PictureData(artist: c_d_Friedrich, imagePrefix : "Friedrich", nameOfPicture: friedrichPicName, pictureText: friedrichPicText, startPosition: 7, picLink: friedrichPicLink)
var friedrichPicture = PictureMadeOfCards(pictureData: friedrich, id: 6)
// 7. Klimt
var g_Klimt = Artist(name: "Klimt", fullName: "Gustav Klimt", artistText: klimtText)
var klimt = PictureData(artist: g_Klimt, imagePrefix : "Klimt", nameOfPicture: klimtPicName, pictureText: klimtPicText, startPosition: 1, picLink: klimtPicLink)
var klimtPicture = PictureMadeOfCards(pictureData: klimt, id: 7)
// 8. Klee
var p_Klee = Artist(name: "Klee", fullName: "Paul Klee", artistText: kleeText)
var klee = PictureData(artist: p_Klee, imagePrefix : "Klee", nameOfPicture: kleePicName, pictureText: kleePicText, startPosition: 1, picLink: kleePicLink)
var kleePicture = PictureMadeOfCards(pictureData: klee, id: 8)
// 9. Baluschek
var h_Baluschek = Artist(name: "Baluschek", fullName: "Hans Baluschek", artistText: baluschekText)
var baluschek = PictureData(artist: h_Baluschek, imagePrefix : "Baluschek", nameOfPicture: baluschekPicName, pictureText: baluschekPicText, startPosition: 0, picLink: baluschekPicLink)
var baluschekPicture = PictureMadeOfCards(pictureData: baluschek, id: 9)
// 10. Holbein
var h_Holbein = Artist(name: "Holbein", fullName: "Hans Holbein", artistText: holbeinText, customWikiLink: NSLocalizedString("holbeinLink", comment: ""))
var holbein = PictureData(artist: h_Holbein, imagePrefix : "Holbein", nameOfPicture: holbeinPicName, pictureText: holbeinPicText, startPosition: 1, picLink: holbeinPicLink)
var holbeinPicture = PictureMadeOfCards(pictureData: holbein, id: 10)
//11. Marc
var f_Marc = Artist(name: "Marc", fullName: "Franz Marc", artistText: marcText)
var marc = PictureData(artist: f_Marc, imagePrefix : "Marc", nameOfPicture: marcPicName, pictureText: marcPicText, startPosition: 7, picLink: marcPicLink)
var marcPicture = PictureMadeOfCards(pictureData: marc, id: 11)
// 12. Jakuchu
var i_Jakuchu = Artist(name: "Jakuchu", fullName: "Itō Jakuchū", artistText: jakuchuText, customWikiLink: NSLocalizedString("jakuchuLink", comment: ""))
var jakuchu = PictureData(artist: i_Jakuchu, imagePrefix : "Jakuchu", nameOfPicture: jakuchuPicName, pictureText: jakuchuPicText, startPosition: 0, picLink: jakuchuPicLink)
var jakuchuPicture = PictureMadeOfCards(pictureData: jakuchu, id: 12)
// 13. Leyster
var j_Leyster = Artist(name: "Leyster", fullName: "Judith Leyster", artistText: leysterText)
var leyster = PictureData(artist: j_Leyster, imagePrefix : "Leyster", nameOfPicture: leysterPicName, pictureText: leysterPicText, startPosition: 6, picLink: leysterPicLink)
var leysterPicture = PictureMadeOfCards(pictureData: leyster, id: 13)
// 14. Merian
var m_s_Merian = Artist(name: "Merian", fullName: "Maria Sybilla Merian", artistText: merianText)
var merian = PictureData(artist: m_s_Merian, imagePrefix : "Merian", nameOfPicture: merianPicName, pictureText: merianPicText, startPosition: 1, picLink: merianPicLink)
var merianPicture = PictureMadeOfCards(pictureData: merian, id: 14)
// 15. Spitzweg
var c_Spitzweg = Artist(name: "Spitzweg", fullName: "Carl Spitzweg", artistText: spitzwegText)
var spitzweg = PictureData(artist: c_Spitzweg, imagePrefix : "Spitzweg",nameOfPicture: spitzwegPicName, pictureText: spitzwegPicText, startPosition: 0, picLink: spitzwegPicLink)
var spitzwegPicture = PictureMadeOfCards(pictureData: spitzweg, id: 15)
// 16. Delaunay2
var r_Delaunay = Artist(name: "Delaunay2", fullName: "Robert Delaunay", artistText: delaunayText)
var delaunay2 = PictureData(artist: r_Delaunay, imagePrefix : "Delaunay2", nameOfPicture: delaunay2PicName, pictureText: delaunay2PicText, startPosition: 1, picLink: delaunay2PicLink)
var delaunay2Picture = PictureMadeOfCards(pictureData: delaunay2, id: 16)
// 17. Duerer
var a_Duerer = Artist(name: "Duerer", fullName: "Albrecht Dürer", artistText: duererText, customWikiLink : NSLocalizedString("duererLink", comment: ""))
var duerer = PictureData(artist: a_Duerer, imagePrefix : "Duerer", nameOfPicture: duererPicName, pictureText: duererPicText, startPosition: 6, picLink: duererPicLink )
var duererPicture = PictureMadeOfCards(pictureData: duerer, id: 17)

//18. Modersohn
var p_Modersohn = Artist(name: "Modersohn", fullName: "Paula Modersohn-Becker", artistText: modersohnText)
var modersohn = PictureData(artist: p_Modersohn, imagePrefix : "Modersohn", nameOfPicture: modersohnPicName, pictureText: modersohnPicText, startPosition: 2, picLink: modersohnPicLink)
var modersohnPicture = PictureMadeOfCards(pictureData: modersohn, id: 18)

// 19. Delaunay
var delaunay = PictureData(artist: r_Delaunay, imagePrefix : "Delaunay", nameOfPicture: delaunayPicName, pictureText: delaunayPicText, startPosition: 5, picLink: delaunayPicLink)
var delaunayPicture = PictureMadeOfCards(pictureData: delaunay, id: 19)

//20. Kandinsky2
var kandinsky2 = PictureData(artist: w_Kandinsky, imagePrefix : "Kandinsky2", nameOfPicture: kandinsky2PicName, pictureText: kandinsky2PicText, startPosition: 6, picLink: kandinsky2PicLink)
var kandinsky2Picture = PictureMadeOfCards(pictureData: kandinsky2, id: 20)

//21. Monet
var c_Monet = Artist(name: "Monet", fullName: "Claude Monet", artistText: monetText)
var monet = PictureData(artist: c_Monet, imagePrefix : "Monet", nameOfPicture: monetPicName, pictureText: monetPicText, startPosition: 11, picLink: monetPicLink)
var monetPicture = PictureMadeOfCards(pictureData: monet, id: 21)
/**
 # selections wird von der SelectView ausgelesen, die daraus das Auswahlmenü in einer ForEach-Schleife macht und der ArtView alle Daten aus dem PictureMadeOCards weiter gibt
 */
//selections: Die Items müssen in der Reihenfolge ihrer ID sein, das ist durch sorted  sicher gestellt.
//aus der ID und der Position des Arrays erkennt die SelcetView welche Bilder schon gespielt worden sind
var selections = [ kandinskyPicture,  hokusaiPicture, kleePicture, brueghelPicture, rousseauPicture, michelangeloPicture, friedrichPicture,  klimtPicture, baluschekPicture, holbeinPicture, marcPicture, jakuchuPicture, leysterPicture, merianPicture, spitzwegPicture, woodPicture, delaunay2Picture, duererPicture, modersohnPicture, delaunayPicture, kandinsky2Picture, monetPicture].sorted {$0.id < $1.id}



/***
 # Die aussagekräftigsten Detailbilder kommen in dieses Array:
 */
/// pictures and artists' names for BonusMiniGame und StartView
var arrayOfPics = [("Wood_Farbe7", "Grant Wood"),("Wood_Farbe3","Grant Wood") ,("Wood_Farbe4", "Grant Wood"), ("Kandinsky_Farbe12", "Wassily Kandinsky"), ("Kandinsky_Farbe24","Wassily Kandinsky"), ("Kandinsky_Farbe9", "Wassily Kandinsky"),("Hokusai_Farbe19", "Katsushika Hokusai"), ("Hokusai_Farbe7", "Katsushika Hokusai"), ("Hokusai_Farbe25", "Katsushika Hokusai"), ("Brueghel_Farbe7", "Piet Breughel"), ("Brueghel_Farbe12", "Piet Breughel"), ("Brueghel_Farbe14", "Piet Breughel"), ("Rousseau_Farbe9", "Henri Rousseau"), ("Rousseau_Farbe12", "Henri Rousseau"), ("Rousseau_Farbe17","Henri Rousseau"), ("Michelangelo_Farbe3", "Michelangelo"), ("Michelangelo_Farbe17","Michelangelo"), ("Michelangelo_Farbe18","Michelangelo"),("Friedrich_Farbe18", "C. D. Friedrich"),("Friedrich_Farbe15","C. D. Friedrich"), ("Friedrich_Farbe20","C. D. Friedrich"), ("Klimt_Farbe3","Gustav Klimt"), ("Klimt_Farbe12","Gustav Klimt"), ("Klimt_Farbe10","Gustav Klimt"), ("Klee_Farbe18", "Paul Klee"), ("Klee_Farbe13","Paul Klee"), ("Klee_Farbe20", "Paul Klee"), ("Baluschek_Farbe7", "Hans Baluschek"), ("Baluschek_Farbe12", "Hans Baluschek"), ("Holbein_Farbe9", "Hans Holbein"), ("Holbein_Farbe7", "Hans Holbein"), ("Holbein_Farbe10","Hans Holbein"),("Marc_Farbe7", "Franz Marc"),("Marc_Farbe17", "Franz Marc"),("Marc_Farbe13", "Franz Marc"), ("Jakuchu_Farbe17","Ito Jakuchu"), ("Jakuchu_Farbe20","Ito Jakuchu"), ("Jakuchu_Farbe16","Ito Jakuchu"), ("Leyster_Farbe7","Judith Leyster"),  ("Leyster_Farbe9","Judith Leyster"),  ("Leyster_Farbe13","Judith Leyster"),   ("Merian_Farbe2","Maria S. Merian"), ("Merian_Farbe9","Maria S. Merian"), ("Merian_Farbe17", "Maria S. Merian"), ("Spitzweg_Farbe7", "Carl Spitzweg"),  ("Spitzweg_Farbe9", "Carl Spitzweg"), ("Spitzweg_Farbe18", "Carl Spitzweg"), ("Delaunay2_Farbe2", "Robert Delaunay"), ("Delaunay2_Farbe14", "Robert Delaunay"), ("Delaunay2_Farbe9", "Robert Delaunay"), ("Duerer_Farbe7", "Albrecht Dürer"), ("Duerer_Farbe14", "Albrecht Dürer"), ("Duerer_Farbe15", "Albrecht Dürer"), ("Modersohn_Farbe8", "Paula Modersohn-Becker"), ("Modersohn_Farbe9", "Paula Modersohn-Becker"), ("Modersohn_Farbe23", "Paula Modersohn-Becker"), ("Delaunay_Farbe6", "Robert Delaunay"), ("Delaunay_Farbe14", "Robert Delaunay"), ("Delaunay_Farbe17", "Robert Delaunay"), ("Kandinsky2_Farbe11", "Wassily Kandinsky"), ("Kandinsky2_Farbe13", "Wassily Kandinsky"),("Kandinsky2_Farbe15", "Wassily Kandinsky"), ("Monet_Farbe17","Claude Monet"), ("Kandinsky2_Farbe13", "Wassily Kandinsky"),("Kandinsky2_Farbe13", "Wassily Kandinsky"), ].shuffled()

