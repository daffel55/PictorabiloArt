//
//  SettingsView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 29.04.23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var timeInterval : Double
    @Binding var showSettings : Bool
    @Binding var withTimer : Bool
   
    @State var showInfo : Bool = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color("Background").ignoresSafeArea()
                ScrollView {
                    VStack {
                        
                        Button(action: {
                            showInfo.toggle()
                        }, label: {
                            Text(showInfo ? NSLocalizedString("hideInfo", comment: "hide Info") : "Info").font(.title).foregroundColor(Color("Color_orange")).underline()
                        })
                        Text(showInfo ? NSLocalizedString("settingsExpl", comment: "Info about settings") : "").padding(.horizontal, 40)
                            .multilineTextAlignment(.leading).font(.title).foregroundColor(foreC)
                     
                        TimeSlider(timeInterval: $timeInterval, geo: geo)
                        Group {
                          
                            
                            Button(action: {
                                if timeInterval < 200 {
                                    timeInterval = 600.0
                                } else {
                                    timeInterval = 2.0
                                }
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("DarkBackground"))
                                    Text(timeInterval < 200 ?  NSLocalizedString("timerOff", comment: "") : NSLocalizedString("timerOn", comment: ""))
                                        .font(.title2)
                                        .foregroundColor(Color("Color_orange"))
                                        
                                }.frame(width: 300, height: 40)
                            })
                           
                          
                            Button(NSLocalizedString("applyQuit", comment: "")) {
                                showSettings = false
                            }.buttonStyle(ChooseButtonSmaler()).padding(30)
                            
                        }
                        
                        Divider().frame(width: 300, height: 5).overlay(content: {
                            foreC
                        })
                        Spacer()
                        SoundSettings()
                        Spacer()
                        Button(NSLocalizedString("applyQuit", comment: "")) {
                            showSettings = false
                        }.buttonStyle(ChooseButtonSmaler(fillColor: Color("Color_marker"))).padding(30)

                    }
                }
                
                
                
            }
        }
       
    }
    
}

