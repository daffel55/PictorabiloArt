//
//  ChooseButton.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 02.06.23.
//MARK: NEU
import SwiftUI
/// A button with a frame of 300x80
/// there is a parameter fillColor that defaults to .lightstandard, but can be changed
struct ChooseButton : ButtonStyle {
    var fillColor = Color.lightStandard
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(fillColor)
            configuration.label
                .font(.largeTitle)
                .foregroundColor(.darkStandard)
        }.frame(width: 300, height: 80)
    }
}
/// A button with a frame of 300x80
/// there is a parameter fillColor that defaults to .lightstandard, but can be changed
struct ChooseButtonSmaler : ButtonStyle {
    var fillColor = Color.lightOrange
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(fillColor)
            configuration.label
                .font(.title2)
                .foregroundColor(Color.darkStandard)
        }.frame(width: 300, height: 40)
    }
}
