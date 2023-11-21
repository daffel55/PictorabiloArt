//
//  ColorData.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 12.06.23.
//MARK: NEU

import SwiftUI

struct ColorData {
    private let COLOR_KEY = "COLOR_KEY"
    private let userDefaults = UserDefaults.standard
    
    func saveColor(color : Color) {
        let color = UIColor(color).cgColor
        if let components = color.components {
            userDefaults.set(components, forKey: COLOR_KEY)
        }
    }
    func loadColor() -> Color {
        guard let array = userDefaults.object(forKey: COLOR_KEY) as? [CGFloat] else {return Color.darkStandard}
        let color = Color(.sRGB,
                          red: array[0],
                            green: array[1],
                          blue: array[2],
        opacity: array[3])
        return color
            
    }
}

