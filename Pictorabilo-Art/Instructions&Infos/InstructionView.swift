//
//  InstructionView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 17.04.23.
//

import SwiftUI

struct InstructionView: View {
    @Binding var shoInstructionView : Bool
    @Binding var instructionHasBeenShwon : Bool
    //let image1 =  UIImage(named: "Tutorial")!
    var body: some View {
        
        ZStack {
            Color("Background").ignoresSafeArea()
            
            Image("Tutorial").resizable().scaledToFit().ignoresSafeArea()
            VStack {
                Spacer()
                Button(NSLocalizedString("next", comment: "")) {
                    instructionHasBeenShwon = true
                    shoInstructionView = false
                }.padding(.bottom, 5)
                    .offset(CGSize(width: 50, height: 0))
                    .buttonStyle(BackButton())
            }
            
        }
        
    }
}
