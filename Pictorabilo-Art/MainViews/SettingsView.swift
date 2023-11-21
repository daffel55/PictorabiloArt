//
//  SettingsView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 08.06.23.
//MARK: NEU

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings : Bool

    @AppStorage("timeInterval") var timeInterval = 5.0
    @AppStorage("withTimer") var withTimer = true
    @AppStorage("useSound") var useSound = true
    @AppStorage("backgroundColor") var backgroundColor = "Background"
    var geo : GeometryProxy
    @State var color = Color.darkStandard
    @State var colorSaved = false
    @State var initialColor = Color.darkStandard
    @State var showColorWarning = false
    
    var colorData = ColorData()
    @State private var isExpanded = false
    var body: some View {
        ZStack {
            Rectangle().fill(color)
                .frame(width: isIPad ? geo.size.width / 2 : geo.size.width / 1.4, height: geo.size.height * 2 / 3)
                .shadow(color: .black, radius: 15, x: 10, y: 2)
            VStack {
                Text(NSLocalizedString("settings", comment: "")).font(.largeTitle).foregroundColor(.lightStandard)
                Form {
                    Section {
                        Toggle(isOn: $withTimer, label: {
                            Text(withTimer ? NSLocalizedString("timerOff", comment: "") : NSLocalizedString("timerOn", comment: ""))
                        })
                        .listRowBackground(Color.lightStandard)
                        DisclosureGroup(withTimer ? NSLocalizedString("interval", comment: "") : NSLocalizedString("noTimer", comment: ""), isExpanded: $withTimer) {
                            if timeInterval < 100 {
                                
                                Text(setTimerText()).font(.title2).foregroundColor(Color.darkStandard)
                            } else {
                                Text(NSLocalizedString("noTimer", comment: "")).font(.largeTitle).foregroundColor(Color("Color_orange"))
                            }
                            Slider(value: $timeInterval, in: 0.25 ... 5, step: 0.25, minimumValueLabel: Text("0.25 sec"), maximumValueLabel: Text("5 sec"), label: {
                                Text("")
                            }).disabled(!withTimer)
                        }
                        
                    } header: {
                        Text(NSLocalizedString("timer", comment: "")).foregroundColor(.lightStandard).font(.title)
                    }
                    
                    Section {
                        Toggle(isOn: $useSound, label: {
                            Text(useSound ? NSLocalizedString("soundOff", comment: "") : NSLocalizedString("soundOn", comment: ""))
                        })
                    } header: {
                        Text("SOUND").foregroundColor(.lightStandard).font(.title)
                    }
                    
                    Section {
                        ColorPick(chosenColor: $color, colorSaved: $colorSaved)
                        Button(colorSaved ? NSLocalizedString("SaveYes", comment: "") : NSLocalizedString("SavePlease", comment: "")) {
                            colorData.saveColor(color: color)
                            colorSaved = true
                        }.buttonStyle(.borderless)
                        Button(NSLocalizedString("defaultColor", comment: "")) {
                            color = .darkStandard
                            colorData.saveColor(color: color)
                        }
                        Text(NSLocalizedString("ColorExpl", comment: "Explanation on how color menu works"))
                    } header: {
                        Text(NSLocalizedString("color", comment: "")).foregroundColor(.lightStandard).font(.title)
                    }
                }
                //.scrollContentBackground(.hidden)
                
                BottomButton(numberOfButton: 1, buttonActions: [{
                    if initialColor != color && !colorSaved {
                        showColorWarning = true
                    } else {
                        showSettings = false
                    }
                }], imageNames: ["x.circle"], texts: [NSLocalizedString("close", comment: "")])
            }
            .frame(width: isIPad ? geo.size.width / 2 : geo.size.width / 1.4, height: geo.size.height * 2 / 3)
            .onAppear(perform: {
                color = colorData.loadColor()
                initialColor = color
            })
            .alert(isPresented:$showColorWarning) {
                Alert(
                    title: Text(NSLocalizedString("WantToSave?", comment: "")),
                    
                    primaryButton: .cancel(Text(NSLocalizedString("DontSave", comment: ""))) {
                        showSettings = false
                    },
                    secondaryButton: .default(Text(NSLocalizedString("Save", comment: ""))) {
                        colorData.saveColor(color: color)
                        initialColor = color
                        showSettings = false
                    }
                )
            }
        }
           
            
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

