//
//  TimeSlider.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 04.05.23.
//

import SwiftUI

struct TimeSlider: View {
    @Binding var timeInterval : Double
    var geo : GeometryProxy
    
    var body: some View {
        VStack {
            if timeInterval < 100 {
                
                Text(setTimerText()).font(.title).foregroundColor(Color("Color_orange"))
            } else {
                Text(NSLocalizedString("noTimer", comment: "")).font(.largeTitle).foregroundColor(Color("Color_orange"))
            }
            Slider(value: $timeInterval, in: 0.25 ... 5, step: 0.25, minimumValueLabel: Text("0.25 sec"), maximumValueLabel: Text("5.0 sec"), label: {}).padding(20).background(content: {
                Capsule().fill(Color("Color_orange")).accentColor(Color("Background"))
            })
        }.frame(width:geo.size.width - 50)
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


