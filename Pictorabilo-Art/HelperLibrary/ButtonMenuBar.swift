//
//  ButtonMenuBar.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 21.11.23.
//

import Foundation
//
//  BottomMenuBar.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 08.07.23.
//

import SwiftUI
/// this is the bar that holds back button, joker button, settings button and info button beneath the ArtView25x25
/// Parameter: game: ArtGameModel and control: GameViewControl
struct BottomMenuBar: View {
    @Binding var game : ArtGameModel
    @Binding var control : GameViewControl
    var body: some View {
        HStack {
            Button(action: {
                control.showQuitDialog = true
            }, label: {
                Image(systemName: GameConstants.backImage).textStyleLarge(deviceType: deviceType)
            }).buttonStyle(color: .lightStandard).padding()
                .disabled(game.allAreMatched())
            Spacer()
            Button(action: {
                jokerButtonAction()
            }, label: {
                spellJoker().textStyleLarge(deviceType: deviceType)
            })
            .disabled( 1...4 ~= game.correctPicCount)
            .buttonStyle(color: .lightGreen)
            Spacer()
            Button(action: {
                control.gotoSettingsView = true
            }, label: {
                Image(systemName: GameConstants.settingsImage).textStyleLarge(deviceType: deviceType)
            }).buttonStyle(color: .lightStandard)
                .disabled(control.allowTap)
            Spacer()
            Button(action: {
                control.showInstructionView = true
            }, label: {
                Image(systemName: GameConstants.infoImage).textStyleLarge(deviceType: deviceType)
            }).buttonStyle(color: .lightStandard).padding(.horizontal)
            
        }.font(.title2).padding(.horizontal, isIPad ? 50 : 20)
    }
    /// taking a Joker sets correctPicCount to 0,
    /// 5 correct clicks regain a joker
    /// this is visible to the user in contructing the word 'joker' letter by letter
    func spellJoker() -> Text {
        var jokerString = ""
        let letters = ["J", "o", "k", "e", "r"]
        if game.correctPicCount == 0 || game.correctPicCount > 4 {
            jokerString = "Joker"
        } else if game.correctPicCount < 5 {
            for i in 0...(game.correctPicCount - 1) {
                jokerString.append(letters[i])
            }
        }
        return Text(jokerString) .foregroundColor(game.hasJoker ? .lightGreen : .clear)
    }
    /// a joker can only be taken if there is a joker available (3 times and always after 5 correct clicks (first joker immediately)
    /// a joker makes only sence if you havent already clicked on a card, so it is only activated if allowTap is true
    func jokerButtonAction() {
        if game.hasJoker && control.allowTap {
            game.takeJoker()
            control.allowTap = false // as long as joker is shown no click on card possible
            // you can well click on everything else, the jokerView stays open unless it is closed
            control.showJoker = true // this is handled in ArtGame
        }
    }
}

