//
//  SoundSettings.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 04.05.23.
//

import SwiftUI

struct SoundSettings: View {
    @AppStorage("useSound") var useSound = true
    var body: some View {
        Group {
            Text("Audio").font(.largeTitle).padding(40)
            HStack {
                Text("Soundeffekte: ").font(.title).padding(.bottom,0)
                Image(systemName: useSound ? "speaker" : "speaker.slash").font(.title)
            }
            Button(action: {
                useSound.toggle()
               
            }, label: {

                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("DarkBackground"))
                    HStack {
                        Text(useSound ?  NSLocalizedString("soundOff", comment: "turn off sound") : NSLocalizedString("soundOn", comment: "turn on sound"))
                            .font(.title2)
                            .foregroundColor(Color("Color_marker"))
                    }
                        
                }.frame(width: 300, height: 40)
            }).padding(10)
            
        }.foregroundColor(Color("Color_marker"))

    }
}


