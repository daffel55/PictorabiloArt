//
//  ColorPick.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 13.06.23.
//MARK: NEU

import SwiftUI

struct ColorPick: View {
    var colors = ["Color_red", "Color_orange", "Color_yellow", "Color_green", "Color_blue", "Color_purple", "Color_gray", "DarkStandard", "Color_black", "Color_white" ]
    @Binding var chosenColor : Color
    @Binding var colorSaved : Bool
    var body: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 5){
                HStack {
                    ForEach(0..<5) { i in
                        Image(systemName: "square.fill")
                            .foregroundColor(Color(colors[i]))
                            .font(.largeTitle)
                            .shadow(color: isChosenColor(i: i) ? .clear : .black, radius: 3, x: 2, y: 2)
                            .onTapGesture {
                                if !isChosenColor(i: i) {
                                    
                                    colorSaved = false
                                }
                                chosenColor = Color(colors[i])
                            }
                        
                    }
                }
                HStack {
                    ForEach(0..<5) { i in
                        Image(systemName: "square.fill")
                            .foregroundColor(Color(colors[i + 5]))
                            .font(.largeTitle)
                            .shadow(color: isChosenColor(i: i + 5) ? .clear : .black, radius: 3, x: 2, y: 2)
                            .onTapGesture {
                                if !isChosenColor(i: i + 5) {
                                    
                                    colorSaved = false
                                }
                                chosenColor = Color(colors[i + 5])
                            }
                        
                    }
                }
            }
        }
        
        
    }
    func isChosenColor(i : Int) -> Bool {
        return  Color(colors[i]) == chosenColor
           
    }
}



