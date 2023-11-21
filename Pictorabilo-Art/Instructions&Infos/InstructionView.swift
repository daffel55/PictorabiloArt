//
//  InstructionView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 02.06.23.
//MARK: NEU

import SwiftUI

struct InstructionView: View {
    @Binding var showInstructionView : Bool
    let widthSize = 250.0
    var body: some View {
        
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                ZStack {
                    Rectangle().fill(Color.white).frame(height: 50)
                    Text(NSLocalizedString("instruction", comment: "")).font(.largeTitle).foregroundColor(.black)
                }
                ScrollView(.vertical) {
                    VStack(alignment: .center, spacing: 20) {
                        Text(NSLocalizedString("publicDomain", comment: "")).foregroundColor(.gray)
                        Text(NSLocalizedString("paintingsInLines", comment: "paintings are shwon in lines"))
                        InstructionsText(widthSize: widthSize)
                        Group {
                            Text("JOKER").font(.title)
                            Text(NSLocalizedString("takeJoker", comment: ""))
                        }
                    }.foregroundColor(.black).padding()
                    HStack {
                        Text(NSLocalizedString("settings", comment: "")).font(.title)
                        Image(systemName: "gearshape").font(.title)
                    }.padding(.bottom, 0).foregroundColor(.black)
                    Text(NSLocalizedString("settingsExplained", comment: "")).padding(.horizontal).foregroundColor(.black)
                }
                BottomButton(numberOfButton: 1, buttonActions: [{
                    showInstructionView = false
                }], imageNames: [GameConstants.backImage], texts: [""])
            }
            }//VStack
        }//zStack
        
    }//body
    


struct InstructionsText :  View {
    var widthSize : Double
    var body: some View {
        VStack {
            
            Group {
                
                
                
                Image("Tutorial1").resizable().scaledToFit().frame(width: widthSize)
                Text(NSLocalizedString("memorizeDetail", comment: ""))
                Image("Tutorial2").resizable().scaledToFit().frame(width: 150)
                Text(NSLocalizedString("tapNext", comment: ""))
                Image("Tutorial3").resizable().scaledToFit().frame(width: widthSize)
                Text(NSLocalizedString("colorPicture", comment: ""))
                Image("Tutorial4").resizable().scaledToFit().frame(width: widthSize)
                Text(NSLocalizedString("beCareful", comment: ""))
            }
            
            
        }
    }
    
}
