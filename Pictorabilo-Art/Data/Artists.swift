//
//  Artists.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 09.05.23.
//

import Foundation
/**
 #alle Künstler werden erst als ArtistData() angelegt und daraus ein PictureMadeOfCards() erstellt
 */
// 0. Wood
var wood = ArtistData(artistname: "Wood", fullNameOfPainter: "Grant Wood", nameOfPicture: woodPicName, startPosition: 1, artistText: woodText)
var woodPicture = PictureMadeOfCards(cards: wood.artistCards, selctionImageName: wood.selectionImageName, painter: wood.fullNameOfPainter, pictureName: wood.nameOfPicture, painterText: wood.artistText, miniArray: wood.cardsMiniArtist, miniArrayLarge: wood.cardsMiniLargeArtist, id: 0)
// 1.Kandinsky
var kandinsky = ArtistData(artistname: "Kandinsky", fullNameOfPainter: "Wassily Kandinsky", nameOfPicture: kandinskyPicName, startPosition: 6, artistText: kandinskyText)
var kandinskyPicture = PictureMadeOfCards(cards: kandinsky.artistCards, selctionImageName: kandinsky.selectionImageName, painter: kandinsky.fullNameOfPainter, pictureName: kandinsky.nameOfPicture, painterText: kandinsky.artistText, miniArray: kandinsky.cardsMiniArtist, miniArrayLarge: kandinsky.cardsMiniLargeArtist, id: 1)
// 2. Hokusai
var hokusai = ArtistData(artistname: "Hokusai", fullNameOfPainter: "Katsushika Hokusai", nameOfPicture: hokusaiPicName, startPosition: 0, artistText: hokusaiText)
var hokusaiPicture = PictureMadeOfCards(cards: hokusai.artistCards, selctionImageName: hokusai.selectionImageName, painter: hokusai.fullNameOfPainter, pictureName: hokusai.nameOfPicture, painterText: hokusai.artistText, miniArray: hokusai.cardsMiniArtist, miniArrayLarge: hokusai.cardsMiniLargeArtist, id: 2)
// 3. Brueghel
var brueghel = ArtistData(artistname: "Brueghel", fullNameOfPainter: "Pieter Brueghel der Jüngere", nameOfPicture: brueghelPicName, startPosition: 7, artistText: brueghelText)
var brueghelPicture = PictureMadeOfCards(cards: brueghel.artistCards, selctionImageName: brueghel.selectionImageName, painter: brueghel.fullNameOfPainter, pictureName: brueghel.nameOfPicture, painterText: brueghel.artistText, miniArray: brueghel.cardsMiniArtist, miniArrayLarge: brueghel.cardsMiniLargeArtist, id: 3)
// 4.Rousseau
var rousseau = ArtistData(artistname: "Rousseau", fullNameOfPainter: "Henri Rousseau", nameOfPicture: rousseauPicName, startPosition: 6, artistText: rousseauText)
var rousseauPicture = PictureMadeOfCards(cards: rousseau.artistCards, selctionImageName: rousseau.selectionImageName, painter: rousseau.fullNameOfPainter, pictureName: rousseau.nameOfPicture, painterText: rousseau.artistText, miniArray: rousseau.cardsMiniArtist, miniArrayLarge: rousseau.cardsMiniLargeArtist, id: 4)
// 5. Michelangelo
var michelangelo = ArtistData(artistname: "Michelangelo", fullNameOfPainter: "Michelangelo", nameOfPicture: michelangeloPicName, startPosition: 6, artistText: michelangeloText)
var michelangeloPicture = PictureMadeOfCards(cards: michelangelo.artistCards, selctionImageName: michelangelo.selectionImageName, painter: michelangelo.fullNameOfPainter, pictureName: michelangelo.nameOfPicture, painterText: michelangelo.artistText, miniArray: michelangelo.cardsMiniArtist, miniArrayLarge: michelangelo.cardsMiniLargeArtist, id: 5)
// 6. Friedrich
var friedrich = ArtistData(artistname: "Friedrich", fullNameOfPainter: "C.D.Friedrich", nameOfPicture: friedrichPicName, startPosition: 7, artistText: friedrichText)
var friedrichPicture = PictureMadeOfCards(cards: friedrich.artistCards, selctionImageName: friedrich.selectionImageName, painter: friedrich.fullNameOfPainter, pictureName: friedrich.nameOfPicture, painterText: friedrich.artistText, miniArray: friedrich.cardsMiniArtist, miniArrayLarge: friedrich.cardsMiniLargeArtist, id: 6)
// 7. Klimt
var klimt = ArtistData(artistname: "Klimt", fullNameOfPainter: "Gustav Klimt", nameOfPicture: klimtPicName, startPosition: 1, artistText: klimtText)
var klimtPicture = PictureMadeOfCards(cards: klimt.artistCards, selctionImageName: klimt.selectionImageName, painter: klimt.fullNameOfPainter, pictureName: klimt.nameOfPicture, painterText: klimt.artistText, miniArray: klimt.cardsMiniArtist, miniArrayLarge: klimt.cardsMiniLargeArtist, id: 7)
// 8. Klee
var klee = ArtistData(artistname: "Klee", fullNameOfPainter: "Paul Klee", nameOfPicture: kleePicName, startPosition: 1, artistText: kleeText)
var kleePicture = PictureMadeOfCards(cards: klee.artistCards, selctionImageName: klee.selectionImageName, painter: klee.fullNameOfPainter, pictureName: klee.nameOfPicture, painterText: klee.artistText, miniArray: klee.cardsMiniArtist, miniArrayLarge: klee.cardsMiniLargeArtist, id: 8)
// 9. Baluschek
var baluschek = ArtistData(artistname: "Baluschek", fullNameOfPainter: "Hans Baluschek", nameOfPicture: baluschekPicName, startPosition: 0, artistText: baluschekText)
var baluschekPicture = PictureMadeOfCards(cards: baluschek.artistCards, selctionImageName: baluschek.selectionImageName, painter: baluschek.fullNameOfPainter, pictureName: baluschek.nameOfPicture, painterText: baluschek.artistText, miniArray: baluschek.cardsMiniArtist, miniArrayLarge: baluschek.cardsMiniLargeArtist, id: 9)
// 10. Holbein
var holbein = ArtistData(artistname: "Holbein", fullNameOfPainter: "Hans Holbein", nameOfPicture: holbeinPicName, startPosition: 1, artistText: holbeinText)
var holbeinPicture = PictureMadeOfCards(cards: holbein.artistCards, selctionImageName: holbein.selectionImageName, painter: holbein.fullNameOfPainter, pictureName: holbein.nameOfPicture, painterText: holbein.artistText, miniArray: holbein.cardsMiniArtist, miniArrayLarge: holbein.cardsMiniLargeArtist, id: 10)


// 11. Jakuchu
var jakuchu = ArtistData(artistname: "Jakuchu", fullNameOfPainter: "Itō Jakuchū", nameOfPicture: jakuchuPicName, startPosition: 0, artistText: jakuchuText)
var jakuchuPicture = PictureMadeOfCards(cards: jakuchu.artistCards, selctionImageName: jakuchu.selectionImageName, painter: jakuchu.fullNameOfPainter, pictureName: jakuchu.nameOfPicture, painterText: jakuchu.artistText, miniArray: jakuchu.cardsMiniArtist, miniArrayLarge: jakuchu.cardsMiniLargeArtist, id: 11)
// 12. Leyster
var leyster = ArtistData(artistname: "Leyster", fullNameOfPainter: "Judith Leyster", nameOfPicture: leysterPicName, startPosition: 6, artistText: leysterText)
var leysterPicture = PictureMadeOfCards(cards: leyster.artistCards, selctionImageName: leyster.selectionImageName, painter: leyster.fullNameOfPainter, pictureName: leyster.nameOfPicture, painterText: leyster.artistText, miniArray: leyster.cardsMiniArtist, miniArrayLarge: leyster.cardsMiniLargeArtist, id: 12)
// 13. Merian
var merian = ArtistData(artistname: "Merian", fullNameOfPainter: "Maria Sybilla Merian", nameOfPicture: merianPicName, startPosition: 1, artistText: merianText)
var merianPicture = PictureMadeOfCards(cards: merian.artistCards, selctionImageName: merian.selectionImageName, painter: merian.fullNameOfPainter, pictureName: merian.nameOfPicture, painterText: merian.artistText, miniArray: merian.cardsMiniArtist, miniArrayLarge: merian.cardsMiniLargeArtist, id: 13)
// 14. Spitzweg
var spitzweg = ArtistData(artistname: "Spitzweg", fullNameOfPainter: "Carl Spitzweg", nameOfPicture: spitzwegPicName, startPosition: 0, artistText: spitzwegText)
var spitzwegPicture = PictureMadeOfCards(cards: spitzweg.artistCards, selctionImageName: spitzweg.selectionImageName, painter: spitzweg.fullNameOfPainter, pictureName: spitzweg.nameOfPicture, painterText: spitzweg.artistText, miniArray: spitzweg.cardsMiniArtist, miniArrayLarge: spitzweg.cardsMiniLargeArtist, id: 14)
// 15. Delaunay2
var delaunay2 = ArtistData(artistname: "Delaunay2", fullNameOfPainter: "Robert Delaunay", nameOfPicture: delaunayPicName, startPosition: 1, artistText: delaunay2Text)
var delaunay2Picture = PictureMadeOfCards(cards: delaunay2.artistCards, selctionImageName: delaunay2.selectionImageName, painter: delaunay2.fullNameOfPainter, pictureName: delaunay2.nameOfPicture, painterText: delaunay2.artistText, miniArray: delaunay2.cardsMiniArtist, miniArrayLarge: delaunay2.cardsMiniLargeArtist, id: 15)

/**
 # selections wird von der SelectView ausgelesen, die daraus das Auswahlmenü in einer ForEach-Schleife macht und der ArtView alle Daten aus dem PictureMadeOCards weiter gibt
 */
//selections: Die Items müssen in der Reihenfolge ihrer ID sein, das ist durch sorted  sicher gestellt.
//aus der ID und der Position des Arrays erkennt die SelcetView welche Bilder schon gespielt worden sind
var selections = [ kandinskyPicture,  hokusaiPicture, kleePicture, brueghelPicture, rousseauPicture, michelangeloPicture, friedrichPicture,  klimtPicture, baluschekPicture, holbeinPicture, jakuchuPicture, leysterPicture, merianPicture, spitzwegPicture, woodPicture, delaunay2Picture].sorted {$0.id < $1.id}



/***
 # Die aussagekräftigsten Detailbilder kommen in dieses Array:
 */
// pictures and artists' names for BonusMiniGame und StartView
var arrayOfPics = [("Wood_Farbe7", "Grant Wood"),("Wood_Farbe3","Grant Wood") ,("Wood_Farbe4", "Grant Wood"), ("Kandinsky_Farbe12", "Wassily Kandinsky"), ("Kandinsky_Farbe24","Wassily Kandinsky"), ("Kandinsky_Farbe9", "Wassily Kandinsky"),("Hokusai_Farbe19", "Katsushika Hokusai"), ("Hokusai_Farbe7", "Katsushika Hokusai"), ("Hokusai_Farbe25", "Katsushika Hokusai"), ("Brueghel_Farbe7", "Piet Breughel"), ("Brueghel_Farbe12", "Piet Breughel"), ("Brueghel_Farbe14", "Piet Breughel"), ("Rousseau_Farbe9", "Henri Rousseau"), ("Rousseau_Farbe12", "Henri Rousseau"), ("Rousseau_Farbe17","Henri Rousseau"), ("Michelangelo_Farbe3", "Michelangelo"), ("Michelangelo_Farbe17","Michelangelo"), ("Michelangelo_Farbe18","Michelangelo"),("Friedrich_Farbe18", "C. D. Friedrich"),("Friedrich_Farbe15","C. D. Friedrich"), ("Friedrich_Farbe20","C. D. Friedrich"), ("Klimt_Farbe3","Gustav Klimt"), ("Klimt_Farbe12","Gustav Klimt"), ("Klimt_Farbe10","Gustav Klimt"), ("Klee_Farbe18", "Paul Klee"), ("Klee_Farbe13","Paul Klee"), ("Klee_Farbe20", "Paul Klee"), ("Baluschek_Farbe7", "Hans Baluschek"), ("Baluschek_Farbe12", "Hans Baluschek"), ("Holbein_Farbe9", "Hans Holbein"), ("Holbein_Farbe7", "Hans Holbein"), ("Holbein_Farbe10","Hans Holbein"), ("Jakuchu_Farbe17","Ito Jakuchu"), ("Jakuchu_Farbe20","Ito Jakuchu"), ("Jakuchu_Farbe16","Ito Jakuchu"), ("Leyster_Farbe7","Judith Leyster"),  ("Leyster_Farbe9","Judith Leyster"),  ("Leyster_Farbe13","Judith Leyster"),   ("Merian_Farbe2","Maria S. Merian"), ("Merian_Farbe9","Maria S. Merian"), ("Merian_Farbe17", "Maria S. Merian"), ("Spitzweg_Farbe7", "Carl Spitzweg"),  ("Spitzweg_Farbe9", "Carl Spitzweg"), ("Spitzweg_Farbe18", "Carl Spitzweg"), ("Delaunay2_Farbe2", "Robert Delaunay"), ("Delaunay2_Farbe14", "Robert Delaunay"), ("Delaunay2_Farbe9", "Robert Delaunay") ].shuffled()

