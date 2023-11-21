//
//  ArtGame.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 22.05.23.
//MARK: NEU

import SwiftUI

struct ArtGame: View {
    // MARK: Variablen, die übergeben werden
    @Binding var user : UserData
    @Binding var gotoArtGame : Bool
    @Binding var playmode : PlayMode
   
    //Statevariablen, die Spielinhalte halten
    @State var game : ArtGameModel
    var colordata = ColorData()
    @State var gameColor = Color.darkStandard
    
    // MARK: Variablen, die inititalisert sind
    //um subviews bewegen zu können per drag and drop
    @State private var off :CGSize = CGSize(width: 0.0,height: 0.0)
    @State private var viewState = CGSize.zero
    
    
    @State var control = GameViewControl()
    @State private var timeRemaining = 5.0
    @State var timeIsUp = false
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    //Appstoragevariablen
    @AppStorage("timeInterval") var timeInterval = 5.0
    @AppStorage("withTimer") var withTimer = true
    @AppStorage("useSound") var useSound = true
    
    let defaults = UserDefaults.standard
    var body: some View {
        GeometryReader { geo in
            if control.gotoSecondMenu {
                SecondMenuView(game: $game, user: $user)
            }

            else if control.showInstructionView {
                InstructionView(showInstructionView: $control.showInstructionView)
            }
            
            else if control.showImageToFind {
                ImageToFindView(game: $game, playmode: $playmode, showImageToFind: $control.showImageToFind)
                
            } else {
                GeometryReader { geo in
                    ZStack {
                        gameColor.ignoresSafeArea()
                        VStack {
                            Text(game.numberOfJoker > 0 ? NSLocalizedString("youGot", comment: "") + " \(game.numberOfJoker) Joker." : NSLocalizedString("zeroJoker", comment: "")).foregroundColor(.lightStandard).textStyleBasic(deviceType: deviceType)
                            ArtView5x5(game: $game, playmode: $playmode, control: $control, geo: geo).padding(.top, 10)
                            BottomMenuBar(game: $game, control: $control)
                            NextButton(buttonAction: nextButtonAction, text: game.allAreMatched() ? NSLocalizedString("clear", comment: "") : NSLocalizedString("next", comment: ""), withImage: game.allAreMatched() ? false : true).padding(.top, 5).disabled(control.disableNext)
                            
                            
                        }
                        if control.gotoSettingsView {
                            SettingsView(showSettings: $control.gotoSettingsView, geo: geo)
                                
                        }
                        
                    }.onAppear {
                        gameColor = colordata.loadColor()
                        
                    }
                }
                if control.showJoker {
                    Image(randomImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 240)
                        .border(.black, width: 2)
                        .shadow(color: .black, radius: 15, x: 10, y: 2)
                        .padding(.bottom, 20)
                        .overlay(alignment: .topTrailing, content: {
                            Image(systemName: "x.circle.fill").font(.title3).padding(3).foregroundColor(.black)
                        })
                        .offset(x: viewState.width, y: viewState.height)
                        .gesture(
                            DragGesture().onChanged { value in
                                viewState = value.translation
                            }
                                .onEnded { value in
                                    withAnimation(.spring()) {
                                        viewState = .zero
                                    }
                                }
                        )
                        .onTapGesture {
                            control.allowTap = true
                            control.showJoker = false
                        }
                }
                if control.showQuitDialog {
                    ZStack(alignment: .center) {
                        Color.darkStandard.opacity(0.5)
                        QuitDialog(control: $control, gotoArtGame: $gotoArtGame, game: $game).padding(.top, 50).padding(.horizontal)
                    }
                }
            }
        }
    }
    
    func nextButtonAction() {
        timeRemaining = timeInterval
        timeIsUp = false
        control.allowTap = true
        control.disableNext = true
        game.madeMistake = false
        let gameWon = game.allAreMatched()
        game.resetWrongPics()
        switch gameWon {
        case true:
            if useSound {
                SoundManager.instance.playSound(sound: .bell, soundtype: .mp3)
            }
            game.resetGame()
            user.editUserData(id: game.picture.id, mode: playmode.rawValue)
            control.gotoSecondMenu = true
        case false: control.showImageToFind = true
            
        }
    }
    func jokerButtonAction() {
        
        if game.hasJoker && control.allowTap {
            game.takeJoker()
            control.allowTap = false
            control.showJoker = true
        }
    }
    
    func randomImage() -> String {
        switch playmode {
        case .standardLines, .reverseLines: return game.randomCard.content.0
        case .standardColor, .reverseColor: return game.randomCard.content.1
        default: return ""
        }
    }
        
//    func save() {
//        user.encodeUserData(user: user)
//
//    }
    
    
}


struct NextButton: View {
    var buttonAction : () -> ()
    var text : String
    var withImage : Bool
    var body: some View {
        Button(action: buttonAction, label: {
            ZStack{
                Rectangle()
                    .fill(Color.lightStandard)
                    .frame(maxWidth: .infinity, maxHeight: 100)
                HStack {
                    Spacer()
                    Text(text)
                        .foregroundColor(.darkStandard)
                        .font(.title)
                    if withImage {
                        Image(systemName: "forward").foregroundColor(.darkStandard).font(.title)
                        
                    }
                    Spacer()
                }.frame(maxWidth: .infinity)
            }.background(Color.lightStandard.edgesIgnoringSafeArea(.bottom))
        })
    }
    
}

struct TextShadow : ViewModifier {
    var color : Color
    func body(content: Content) -> some View {
        content.foregroundColor(color).shadow(color: .black, radius: 2.5, x: 1.5, y: 1.5)
    }
}
extension View {
    func buttonStyle(color: Color) -> some View {
        modifier(TextShadow(color: color))
    }
}

