//
//  ShowMistakeView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 13.07.23.
//MARK: NEU

import SwiftUI
/// a View that is presented after gameOver to show to the user what card is clicked and what card should be found
struct ShowMistakeView: View {
    @Binding var game: ArtGameModel
    @Binding var playMode : PlayMode
    // the next two parameter ar used to make the view dragggable and return to center after drag
    @State private var off :CGSize = CGSize(width: 0.0,height: 0.0)
    @State private var viewState = CGSize.zero
    
    var body: some View {
        HStack {
//            VStack {
//                Text(NSLocalizedString("found", comment: ""))
//                Image(wrongReaction().0)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 120)
//                    .border(Color.red, width: 2)
//            }
            VStack {
                Text(NSLocalizedString("sought", comment: ""))
                Image(wrongReaction().1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .border(Color.green, width: 2)
            }
            
        }.padding(.horizontal, 40)
            .padding(.vertical, 20)
            .background(Color.lightStandard.opacity(0.8).shadow(color: .black, radius: 15, x: 10, y: 2))
            .foregroundColor(Color.darkStandard)
            .onTapGesture {
                game.madeMistake = false
            }
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
    }
    func wrongReaction() -> (String, String){
        switch playMode {
        case .standardLines, .reverseColor:
            return (game.wrongCard.content.0, game.randomCard.content.0)
        case .standardColor, .reverseLines:
            return (game.wrongCard.content.1, game.randomCard.content.1)
        default: return("","")
        
        }
    }
}

