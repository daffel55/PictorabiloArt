//
//  ArtView25x25.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 07.04.23.
//

import SwiftUI
/**
 TODO: Instructionsmessage unbedingt ganz am Schluß angleichen
 */

struct ArtView25x25: View {
    // MARK: VARIABLEN
    /**
     # Alle Parameter, die beim Aufruf mitgegeben werden*/
    @State var game : ArtModel //die Logik des Spieles
    @Binding var picture : PictureMadeOfCards //das enthält den Namen, die Beschreibung etc des Künstlers
   // @Binding var imageArray : [Card]  //ein Array für die Bildkarten...das ist jetzt im game
    //@Binding  var randomImage : String  //das Bild das gesucht werden soll .. das ist auch im game
    @Binding var goToArtView : Bool //mit goToArtView wird vom Selectionsview ins ArtVIew geganen, wird der Wert false, sind wir wieder im Selectionsview
    @Binding var playmode : PlayMode //eine der 4 Playmodes, davon hängt die Präsentation des RandomImages and des ArtGrids ab
    @Binding var withTimer: Bool
    @Binding var idArr : [Int]
    /**
     # Alle Appstoragevariablen
     */
    @AppStorage("timeInterval") var timeInterval = 0.5
    @AppStorage("instructionShown") var instructionShown = false
    @AppStorage("timerMessageShown") var timerMessageShown = false
    @AppStorage("useSound") var useSound = true
    
    let defaults = UserDefaults.standard
    
    @State  var correct : Bool = false //wird true wenn das richtige Bild gefunden ist
    @State  var showImageToFind : Bool = true //Modus in dem eine Bildkarte gezeigt wird
    @State  var showNextButton = true //ist false, solange der User noch kein Bild angewählt hat
    @State  var tappable = true //ein Bild ist nur tappable, wenn showBigger false, also wenn nicht gerade ein Bild vergrößert gezeigt wird
    @State  var hasJoker = true
    @State  var showJoker = false
    @State  var numberOfJokersLeft = 3
    @State  var correctPictCount = 5
    @State  var showInstructionView = false
    @State  var oldRandomImage = "" //wird bei MistakeView angezeigt
    @State  var currentClickedImage = "" //wird bei MistakeView angezeigt
    @State  var goBack = false // true wenn der User zurück ins Hauptmenu will
    @State  var showInfoText = false // zeigt die Anleitung an
    @State  var showBigger = false //zeigt das gedrückt gehaltene Bild vergrößert an
    @State  var biggerImage = "" // hier wird gespeichert, welches Bild vergrößert gezeigt werden soll
    @State  var showQuitDialog = false //Warnung vor Verlassen des Spiels
   
    @State  var madeMistake = false //true wenn User das falsche Bild wählt
    @State var showMistakeInfo = false //zeigt das falsch geklickte und das eigentlich gesuchte Bild an
    
     //hält die IDs der bereits einmal erfolgreichg espielten Spiele, wird in UserDefaults gespeichert (key: "ids")
    
    @AppStorage("message")  var messageShown = false // wenn das erste Mal der Baum zum Blühen gebracht wird, wird dieser Wert true. Ab jetzt steht das Menu (s. showMenu) zur Verfügung

    
    // MARK: BODY
    
    var body: some View {
        GeometryReader { geo in
            if goBack || game.gameWon { // wenn der Quitdialog mit goBack verlassen wurde oder das Spiel gewonnen wurde, dann wird das Auswahlmenu gezeigt
                if idArr.contains(picture.id) {
                    ChooseModeView(picture: $picture, imageArray: $game.imageArray, withTimer: $withTimer, idArr: $idArr)
                }
            }
            else {
                ZStack { //outer ZStack
                   backC.ignoresSafeArea()
                    VStack { //das ist im Grunde gamebody
                        ZStack {
                            if showInstructionView {
                                InstructionView(shoInstructionView: $showInstructionView,instructionHasBeenShwon: $instructionShown)
                            }
     // MARK: Anzeige des Suchbildes:
                            else if showImageToFind {
                                VStack {
                                    Spacer()
                                    Group {
                                        Text(picture.painter).font(.system(size: 40))
                                        Text(picture.pictureName).font(.title)
                                        Text(NSLocalizedString("modDetail", comment: "modified section")).font(.title)
                                    }
                                        .foregroundColor(foreC)
                                        .padding(.bottom, 10)
                                    if withTimer {
                                        Text(timeInterval < 200 ? setTimerText() : "kein Timer eingestellt") //den Timer ganz ausstellen, lappt nicht, also ist der ausgestellte Timer in Wirklichkeit 600, das heißt timerInterval < 200 ist ein eingestellter Timer
                                        Text( NSLocalizedString("timerChange", comment: "where to change timer"))
                                    }
                                    Spacer()
                                    Spacer()
                                    Text(NSLocalizedString("memorize", comment: "memorize the detail")).font(.title2).foregroundColor(foreC).opacity(0.8)
                                    Spacer()
                                    Image(game.randomImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 240, height: 300)
                                        .onTapGesture {
                                            oldRandomImage = game.randomImage// bei Mistake wird gleich ein neues RandomImage generiert, das oldRandomImage hält das alte RI
                                            showImageToFind = false// geht also in den nächsten Anzeigemodus
                                            tappable = true //Bilder können angeklickt werden
                                            showNextButton = false
                                        }
                                    
                                    
                                    Spacer()
                                    HStack {
                                        backButton
                                        Spacer()
                                        Spacer()
                                        if showImageToFind {
                                            searchButton
                                        } else {
                                            nextButton
                                        }
                                        Spacer()
                                        infoButton
                                        Spacer()
                                        
                                        
                                    } //HStack, der die Buttons hält
                                    .padding()
                                    .padding(.horizontal, 10)
                                    .background(.ultraThinMaterial)
                                    .padding(.top, 20)
                                }
                                .onAppear(perform: {
                                    if withTimer {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
                                            // code to remove your view
                                            showImageToFind = false
                                            showNextButton = false
                                            tappable = true
                                            
                                        }
                                    }
                                })
                            } //if showPattern
                            else if !showImageToFind {
                                
                                VStack(spacing: 10) {
                                    
                                    Text(madeMistake ? NSLocalizedString("wrongPic", comment: "wrong pic found") : NSLocalizedString("findPic", comment: "Find pic")).font(.title2).foregroundColor(Color("Foreground").opacity(0.8))
                                    
                                    VStack(spacing: 2) { //dieser VStack hält die ganzen HStacks (das ist also das Raster für die 25 Bilder)
                                        GridOfArt(picture: $picture, game: $game,  imageArray: $game.imageArray, showJoker: $showJoker, showBigger: $showBigger, tappable: $tappable, biggerImage: $biggerImage, playmode: $playmode, useSound: $useSound, correctPictCount: $correctPictCount, hasJoker: $hasJoker,  madeMistake: $madeMistake, numberOfJokersLeft: $numberOfJokersLeft, showNextButton: $showNextButton, idArr: $idArr, currentClickedImage : $currentClickedImage)
                               
                                        Text(madeMistake ? NSLocalizedString("WantToSeeAgain", comment: "want to see mestake again") : NSLocalizedString("longPress", comment: "long press to Zoom"))
                                            .font(.caption)
                                            .foregroundColor(foreC)
                                            .padding()
                                        if madeMistake {
                                            Button(action: {
                                                tappable = false
                                                showMistakeInfo = true
                                            }, label: {
                                                Text(NSLocalizedString("pressHere", comment: ""))
                                                    .underline()
                                                    .foregroundColor(foreC)
                                                
                                            })
                                        }
                                        Text("Noch \(numberOfJokersLeft) Joker").opacity(numberOfJokersLeft <= 0 || madeMistake ? 0 : 1)
                                       
                                    }
                                    Spacer()
                                    HStack {
                                        backButton
                                        Spacer()
                                        Spacer()
                                        if showImageToFind {
                                            searchButton
                                        } else {
                                            nextButton
                                        }
                                        
                                        Spacer()
                                        joker
                                        Spacer()
                                        
                                        
                                    } //HStack, der die Buttons hält
                                    .padding()
                                    .padding(.horizontal, 10)
                                    .background(.ultraThinMaterial)
                                    .padding(.top, 20).padding(.bottom, 0)
                                    
                                }
                            }//end else (if not shwoPattern
                        } //ende von gamebody
                    } //VStack für Text und das Gitter
                    if showBigger {
                        ZStack {
                            Color.white
                            Image(biggerImage)
                                .resizable()
                                .scaledToFit()
                                
                                .border(.black, width: 2)
                                
                                .overlay(alignment: .topTrailing, content: {
                                    Image(systemName: "x.circle.fill").font(.title3).padding(3).foregroundColor(.black)
                                })
                                .onTapGesture {
                                    tappable = true
                                    showBigger = false
                                }
                        }.frame(width: 180, height: 240)
                    }
                    if showJoker {
                        Image(game.randomImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 240)
                            .border(.black, width: 2)
                            .padding(.bottom, 20)
                            .overlay(alignment: .topTrailing, content: {
                                Image(systemName: "x.circle.fill").font(.title3).padding(3).foregroundColor(.black)
                            })
                            .onTapGesture {
                                tappable = true
                                showJoker = false
                            }
                    }
                    if showQuitDialog {
                        QuitDialog(showBigger: $showBigger, showAlert: $showQuitDialog, idArr: $idArr, picture: $picture, goBack: $goBack, goToArtView: $goToArtView, game: $game)
                    }
                    if showMistakeInfo {
                        MistakeInfo(randImg: oldRandomImage, clickedImg: currentClickedImage, geo: geo, showMistakeInfo: $showMistakeInfo)
                    }
                } //end outer ZStack
                .onDisappear(perform: {
                    game.resetGame()
                })
                
            } //else
            
        } //end geometryreader
    } //end body
    
    
    var backButton : some View {
        
        Button(action : {
           
            showQuitDialog = true
        }, label: {
            Image(systemName: backSign).foregroundColor(.white).font(.title2)
        })
    }
    
    var joker : some View {
        Button(action: {
            if hasJoker && tappable {
                hasJoker = false
                correctPictCount = 0
                showJoker = true
                tappable = false
                numberOfJokersLeft -= 1
            }
            
        }, label: {
            jokerView
        }).disabled(!hasJoker || numberOfJokersLeft <= 0).opacity(madeMistake ? 0 : 1)
    }
    var nextButton : some View {
        Button(action: {
            print("Tappable: \(tappable), showNextButton: \(showNextButton)")
            for index in game.imageArray.indices {
                game.imageArray[index].wrongPic = false
            }
            showImageToFind = true
            madeMistake = false
            if game.checkIfWon() {
               

            }
            
        }, label: {
            Text(madeMistake ? NSLocalizedString("again", comment: "") : NSLocalizedString("next", comment: "")).font(.title).foregroundColor(showNextButton ? .white : .clear)
        })
            //.disabled(!showNextButton)
    }
    var searchButton : some View {
        Button(action: {
            showImageToFind = false
            showNextButton = false
            tappable = true
        }, label: {
            Text(NSLocalizedString("next", comment: "")).font(.largeTitle).foregroundColor(.white)
        })
    }
    
    var infoButton : some View {
        Button(action: {
            if  !showQuitDialog && !showBigger {
                showInstructionView = true
            }
        }, label: {
           
                if showInfoText {
                    Image(systemName: "x.circle")
                } else {
                    Image(systemName: "info.circle")
                }
            
        }).foregroundColor(.white).font(.title2)
    }
    
    
    struct MistakeInfo : View {
        var randImg : String
        var clickedImg : String
        var geo : GeometryProxy
        @Binding var showMistakeInfo : Bool
        var body: some View {
            ZStack(alignment: .bottom) {
                Color.clear
                ZStack {
                   foreC
                    VStack {
                        HStack(alignment: .center, spacing: 20) {
                            
                            VStack {
                                Text(NSLocalizedString("ClickedDetail", comment: ""))
                                Image(clickedImg).resizable().scaledToFit().frame(width: 105, height: 144.5)
                            }
                            VStack {
                                Text(NSLocalizedString("soughtDetail", comment: ""))
                                Image(randImg).resizable().scaledToFit().frame(width: 105, height: 144.5)
                            }
                        }.foregroundColor(Color.black)
                        Button("schließen") {
                            showMistakeInfo = false
                        }
                        
                    }
                }.frame(height: geo.size.height / 4, alignment: .center)
                    .onTapGesture {
                        showMistakeInfo = false
                    }
            }
        }
    }
    
    //429 × 572 pixels
    
    
    func spellJoker() -> String {
        var jokerString = ""
        let letters = ["J", "o", "k", "e", "r"]
        if correctPictCount == 0 {
            return "Joker"
        } else {
            for i in 0...(correctPictCount - 1) {
                jokerString.append(letters[i])
            }
        }
        return jokerString
    }
    
    var jokerView : some View {
        HStack {
            if numberOfJokersLeft <= 0 {
                Image(systemName: "circle.slash").font(.title3)
            } else {
                Text(spellJoker()).foregroundColor(backC).font(.title3)
            }
        }.frame(width: 60).border(Color("Spring"), width: 1).background(numberOfJokersLeft > 0 ? Color.white : Color.clear)
    }

    
    func reset() {
        game.resetGame()
        showImageToFind = true
        showNextButton = true
      
        correctPictCount = 5
        hasJoker = true
        showJoker = false
        
    }
    
    func setTimerText() -> String {
        var text = ""
        text.append(NSLocalizedString("timerInfo", comment: "timer info"))
        text.append("\(String(format: "%.2f", timeInterval)) ")
        text.append(NSLocalizedString("sec", comment: "seconds"))
        text.append(".")
        return text
    }
}


