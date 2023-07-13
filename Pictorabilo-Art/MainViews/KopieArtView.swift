//
////
////  ArtView25x25.swift
////  Pictorabilo-Art
////
////  Created by Dagmar Feldt on 07.04.23.
////
//
//import SwiftUI
//
//struct ArtView25x25: View {
//    @Binding var picture : PictureMadeOfCards
//    @Binding var imageArray : [Card]  //ein Array für die Bildkarten
//    @Binding  var randomImage : String  //das Bild das gesucht werden soll
//    @Binding var selectionsNumber : Int
//    @Binding var goToArtView : Bool
//    @Binding var playmode : PlayMode
//    @Binding var arrayForMini2 : [CardForMini]
//    @Binding var arrayForMini2Large : [CardForMini]
//    @Binding var withTimer: Bool
//    @Binding var jumpNumber : Int
//    @AppStorage("timeInterval") var timeInterval = 0.5
//    @AppStorage("instructionShown") var instructionShown = false
//    @AppStorage("timerMessageShown") var timerMessageShown = false
//    @AppStorage("useSound") var useSound = true
//    @State  var correct : Bool = false //wird true wenn das richtige Bild gefunden ist
//    @State  var showImageToFind : Bool = true //Modus in dem eine Bildkarte gezeigt wird
//    @State  var showNextButton = true //ist false, solange der User noch kein Bild angewählt hat
//    @State  var tappable = true //ein Bild ist nur tappable, wenn showBigger false, also wenn nicht gerade ein Bild vergrößert gezeigt wird
//    @State  var hasJoker = true
//    @State  var showJoker = false
//    @State  var numberOfJokersLeft = 3
//    @State  var correctPictCount = 5
//    @State  var showInstructionView = false
//    
//    @State  var gameWon = false // wenn alle Bilder gefunden worden sind, wird gameWon true
//    @State  var goBack = false // true wenn der User zurück ins Hauptmenu will
//    @State  var showInfoText = false // zeigt die Anleitung an
//    @State  var showBigger = false //zeigt das gedrückt gehaltene Bild vergrößert an
//    @State  var biggerImage = "" // hier wird gespeichert, welches Bild vergrößert gezeigt werden soll
//    @State  var showQuitDialog = false //Warnung vor Verlassen des Spiels
//    @State  var allDealt = true // wird ind diesem Spielmodus nicht gebraucht, nur als Übergabeparameter für Quitdialog
//    @State  var madeMistake = false //true wenn User das falsche Bild wählt
//    @State  var showBirds = false // wenn true wird SecondSpringView aufgerufen (mit den Vöglen)
//    @State  var showMenu = false //zeigt das Menu zum auswählen, ob mit kahlem Baum oder blühenden angefangen wird
//    
//    @AppStorage("message")  var messageShown = false // wenn das erste Mal der Baum zum Blühen gebracht wird, wird dieser Wert true. Ab jetzt steht das Menu (s. showMenu) zur Verfügung
//
//    var divider: CGFloat = 6.0 //zur Berechnung der Kartengröße
//    
//    
//    var body: some View {
//        GeometryReader { geo in
//            if goBack || gameWon {
//                ChooseModeView(picture: $picture, imageArray: $imageArray, arrayForMini2: $arrayForMini2, arrayForMini2Large: $arrayForMini2Large, selectionsNumber: $selectionsNumber, withTimer: $withTimer, jumpnumber: $jumpNumber)
//            }
//            else {
//                
//                ZStack { //outer ZStack
//                    Color("Background").ignoresSafeArea()
//                    VStack { //das ist im Grunde gamebody
//                        ZStack {
//                            if showInstructionView {
//                                InstructionView(shoInstructionView: $showInstructionView,instructionHasBeenShwon: $instructionShown)
//                            }
//        
//                            else if showImageToFind {
//                                
//                                VStack {
//                                    Spacer()
//                                    Group {
//                                        Text(picture.painter).font(.system(size: 40))
//                                        Text(picture.pictureName).font(.title)
//                                        Text(NSLocalizedString("modDetail", comment: "modified section")).font(.title)
//                                    }
//                                    
//                                    .foregroundColor(Color("Foreground"))
//                                    .padding(.bottom, 10)
//                                    if withTimer {
//                                        Text(timeInterval < 200 ? setTimerText() : "kein Timer eingestellt")
//                                        Text( NSLocalizedString("timerChange", comment: "where to change timer"))
//                                    }
//                                    Spacer()
//                                    Spacer()
//                                    Text(NSLocalizedString("memorize", comment: "memprize the detail")).font(.title2).foregroundColor(Color("Foreground").opacity(0.8))
//                                    Spacer()
//                                    Image(randomImage)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 240, height: 300)
//                                        .onTapGesture {
//                                            showImageToFind = false
//                                            tappable = true
//                                        }
//                                    
//                                    
//                                    Spacer()
//                                    HStack {
//                                        backButton
//                                        Spacer()
//                                        Spacer()
//                                        if showImageToFind {
//                                            searchButton
//                                        } else {
//                                            nextButton
//                                        }
//                                        Spacer()
//                                        infoButton
//                                        Spacer()
//                                        
//                                        
//                                    } //HStack, der die Buttons hält
//                                    .padding()
//                                    .padding(.horizontal, 10)
//                                    .background(.ultraThinMaterial)
//                                    .padding(.top, 20)
//                                }
//                                .onAppear(perform: {
//                                    if withTimer {
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
//                                            // code to remove your view
//                                            showImageToFind = false
//                                            showNextButton = false
//                                            tappable = true
//                                            
//                                        }
//                                    }
//                                })
//                            } //if showPattern
//                            else if !showImageToFind {
//                                
//                                VStack(spacing: 10) {
//                                    
//                                    Text(madeMistake ? NSLocalizedString("wrongPic", comment: "wrong pic found") : NSLocalizedString("findPic", comment: "Find pic")).font(.title2).foregroundColor(Color("Foreground").opacity(0.8))
//                                    
//                                    VStack(spacing: 2) { //dieser VStack hält die ganzen HStacks (das ist also das Raster für die 25 Bilder)
//                                        GridOfArt(faktor: 0, imageArray: $imageArray, showJoker: $showJoker, showBigger: $showBigger, tappable: $tappable, biggerImage: $biggerImage, playmode: $playmode, useSound: $useSound, correctPictCount: $correctPictCount, hasJoker: $hasJoker, randomImage: $randomImage, madeMistake: $madeMistake, numberOfJokersLeft: $numberOfJokersLeft, showNextButton: $showNextButton)
//                               
//                                        Text(NSLocalizedString("longPress", comment: "long press to Zoom"))
//                                            .font(.caption)
//                                            .foregroundColor(Color("Foreground"))
//                                            .padding()
//                                        Text("Noch \(numberOfJokersLeft) Joker").opacity(numberOfJokersLeft <= 0 || madeMistake ? 0 : 1)
//                                        
//                                        
//                                    }
//                                    Spacer()
//                                    HStack {
//                                        backButton
//                                        Spacer()
//                                        Spacer()
//                                        if showImageToFind {
//                                            searchButton
//                                        } else {
//                                            nextButton
//                                        }
//                                        
//                                        Spacer()
//                                        joker
//                                        Spacer()
//                                        
//                                        
//                                    } //HStack, der die Buttons hält
//                                    .padding()
//                                    .padding(.horizontal, 10)
//                                    .background(.ultraThinMaterial)
//                                    .padding(.top, 20).padding(.bottom, 0)
//                                    
//                                }
//                            }//end else (if not shwoPattern
//                        } //ende von gamebody
//                    } //VStack für Text und das Gitter
//                    if showBigger {
//                        Image(biggerImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 180, height: 240)
//                            .border(.black, width: 2)
//                            .padding(.bottom, 20)
//                            .overlay(alignment: .topTrailing, content: {
//                                Image(systemName: "x.circle.fill").font(.title3).padding(3).foregroundColor(.black)
//                            })
//                            .onTapGesture {
//                                tappable = true
//                                showBigger = false
//                            }
//                    }
//                    if showJoker {
//                        Image(randomImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 180, height: 240)
//                            .border(.black, width: 2)
//                            .padding(.bottom, 20)
//                            .overlay(alignment: .topTrailing, content: {
//                                Image(systemName: "x.circle.fill").font(.title3).padding(3).foregroundColor(.black)
//                            })
//                            .onTapGesture {
//                                tappable = true
//                                showJoker = false
//                            }
//                    }
//                    if showQuitDialog {
//                        QuitDialog(showBigger: $showBigger, showAlert: $showQuitDialog, allDealt: $allDealt, goBack: $goBack)
//                    }
//                } //end outer ZStack
//                
//            } //else
//            
//        } //end geometryreader
//    } //end body
//    
//    
//    var backButton : some View {
//        
//        Button(action : {
//            showQuitDialog = true
//        }, label: {
//            Image(systemName: "arrowshape.turn.up.backward").foregroundColor(.white).font(.title2)
//        })
//    }
//    
//    var joker : some View {
//        Button(action: {
//            if hasJoker && tappable {
//                hasJoker = false
//                correctPictCount = 0
//                showJoker = true
//                tappable = false
//                numberOfJokersLeft -= 1
//            }
//            
//        }, label: {
//            jokerView
//        }).disabled(!hasJoker || numberOfJokersLeft <= 0).opacity(madeMistake ? 0 : 1)
//    }
//    var nextButton : some View {
//        Button(action: {
//            for index in imageArray.indices {
//                imageArray[index].wrongPic = false
//            }
//            chooseNewRandomImage()
//            showImageToFind = true
//            madeMistake = false
//            if gameWon {
//                SoundManager.instance.playSound(sound: .bell, soundtype: .mp3)
//            }
//            
//        }, label: {
//            Text(madeMistake ? NSLocalizedString("again", comment: "again") : NSLocalizedString("next", comment: "")).font(.title).foregroundColor(.white)
//        })
//        .disabled(!showNextButton)
//    }
//    var searchButton : some View {
//        Button(action: {
//            showImageToFind = false
//            showNextButton = false
//            tappable = true
//        }, label: {
//            Text(NSLocalizedString("next", comment: "")).font(.largeTitle).foregroundColor(.white)
//        })
//    }
//    
//    var infoButton : some View {
//        Button(action: {
//            if  !showQuitDialog && !showBigger {
//                showInstructionView = true
//            }
//        }, label: {
//            if allDealt {
//                if showInfoText {
//                    Image(systemName: "x.circle")
//                } else {
//                    Image(systemName: "info.circle")
//                }
//            } else {
//                Image(systemName: "info.circle")
//            }
//        }).foregroundColor(.white).font(.title2)
//    }
//    
//    
//    
//    
//    
//    
//    
//    func spellJoker() -> String {
//        var jokerString = ""
//        let letters = ["J", "o", "k", "e", "r"]
//        if correctPictCount == 0 {
//            return "Joker"
//        } else {
//            for i in 0...(correctPictCount - 1) {
//                jokerString.append(letters[i])
//            }
//        }
//        return jokerString
//    }
//    
//    var jokerView : some View {
//        HStack {
//            if numberOfJokersLeft <= 0 {
//                Image(systemName: "circle.slash").font(.title3)
//            } else {
//                Text(spellJoker()).foregroundColor(Color("Background")).font(.title3)
//            }
//        }.frame(width: 60).border(Color("Spring"), width: 1).background(numberOfJokersLeft > 0 ? Color.white : Color.clear)
//    }
//    
//    
//    
//    
//    func chooseNewRandomImage() {
//        var randomElement : Card = imageArray[0]
//        var goIntoRepeatLoop = false
//        for index in imageArray.indices {
//            if imageArray[index].isMatched == false {
//                goIntoRepeatLoop = true
//            }
//        }
//        if goIntoRepeatLoop {
//            repeat {
//                randomElement = imageArray.randomElement()!
//                
//            } while (randomElement.isMatched == true)
//            switch playmode {
//            case .standardLines, .reverseLines:
//                randomImage = randomElement.content.0
//            case .standardColor, .reverseColor:
//                randomImage = randomElement.content.1
//            }
//            
//            
//            
//        } else {
//            if selectionsNumber <= picture.id {
//                selectionsNumber = picture.id + 1
//                
//            }
//            reset()
//            gameWon = true
//            goToArtView = false
//        }
//    }
//    
//    func reset() {
//        for index in imageArray.indices {
//            imageArray[index].isMatched = false
//            imageArray[index].wrongPic = false
//        }
//        showImageToFind = true
//        showNextButton = true
//        gameWon = false
//        correctPictCount = 5
//        hasJoker = true
//        showJoker = false
//        
//    }
//    
//    func setTimerText() -> String {
//        var text = ""
//        text.append(NSLocalizedString("timerInfo", comment: "timer info"))
//        text.append("\(String(format: "%.2f", timeInterval)) ")
//        text.append(NSLocalizedString("sec", comment: "seconds"))
//        text.append(".")
//        return text
//    }
//}
//
//struct GridOfArt : View {
//    var faktor : Int
//    @Binding var imageArray :  [Card]
//    @Binding var showJoker : Bool
//    @Binding var showBigger : Bool
//    @Binding var tappable : Bool
//    @Binding var biggerImage : String
//    @Binding var playmode : PlayMode
//    @Binding var useSound : Bool
//    @Binding var correctPictCount : Int
//    @Binding var hasJoker : Bool
//    @Binding var randomImage : String
//    @Binding var madeMistake : Bool
//    @Binding var numberOfJokersLeft : Int
//    @Binding var showNextButton : Bool
//    var body: some View {
//        VStack(spacing: 2){
//            ForEach(0..<5) {row in
//                HStack(spacing: 2){
//                    ForEach(0 ..< 5) { col in
//                        Image(displayPicture(for: imageArray[row*5+col]))
//                            .resizable()
//                            .scaledToFit()
//                        //.frame(width: getAdpatedWidth(size: geo.size))
//                        // .aspectRatio(contentMode: .fit)
//                            .overlay(content: {
//                                if imageArray[row*5+col].wrongPic {
//                                    ZStack {
//                                        Color.white.opacity(0.3)
//                                        Image(randomImage).resizable().aspectRatio(3/4, contentMode: .fit)
//                                        Text("Oh no!").font(.title2)
//                                            .foregroundColor(Color("Background"))
//                                    }
//                                }
//                            })
//                            .onTapGesture {
//                                if showJoker || showBigger {
//                                    showJoker = false
//                                    showBigger = false
//                                    tappable = true
//                                }
//                                
//                                else if tappable {
//                                    showBigger = false
//                                    correctPicture(i: row*5+col)
//                                    
//                                    tappable = false
//                                }
//                            }
//                            .onLongPressGesture(perform: {
//                                tappable = false
//                                biggerImage = getBiggerImage(card: imageArray[row*5+col])
//                                showBigger = true
//                            })
//                    }
//                }
//            }
//        }
//    }
//        func getBiggerImage(card : Card) -> String {
//            switch playmode {
//            case .standardLines, .reverseColor :
//                return card.content.0
//            case .standardColor, .reverseLines:
//                return card.content.1
//            }
//        }
//        func displayPicture(for card : Card) -> String {
//            var str = ""
//            switch playmode {
//            case .standardLines:
//                str = card.isMatched ? card.content.1 : card.content.0 //randomCard hierzu ist card.content.0
//            case .standardColor:
//                str = card.isMatched ? card.content.0 : card.content.1 //randomCard hierzu ist card.content.1
//            case .reverseColor: //farbige Karte  gezeigt, Linienbild zum finden
//                str = card.isMatched ? card.content.1 : card.content.0 //randomCard hierzu ist card.content.1
//            case .reverseLines: //Linienkarte gezeigt, farbige Karte zum Suchen
//                str = card.isMatched ? card.content.0 : card.content.1 //randomCard hierzu ist card.content.0
//            }
//            return str
//        }
//        func correctPicture(i : Int)  {
//            
//            let linesInDetail : Bool = (playmode == .standardLines || playmode == .reverseLines)
//            
//            var nameToCompare : String {
//                linesInDetail ? imageArray[i].content.0 : imageArray[i].content.1
//            }
//            if nameToCompare  == randomImage {
//                if useSound {
//                    SoundManager.instance.playSound(sound: .swap, soundtype: .m4a)
//                }
//                imageArray[i].isMatched = true
//                if !hasJoker {
//                    correctPictCount += 1
//                }
//                if correctPictCount == 5 {
//                    hasJoker = true
//                    correctPictCount = 0
//                }
//            } else {
//                if useSound {
//                    SoundManager.instance.playSound(sound: .ohno, soundtype: .m4a)
//                }
//                imageArray[i].wrongPic = true
//                madeMistake = true
//                hasJoker = true
//                correctPictCount = 5
//                numberOfJokersLeft = 3
//                for index in imageArray.indices {
//                    imageArray[index].isMatched = false
//                }
//            }
//            showNextButton = true
//            
//        }
//    }
