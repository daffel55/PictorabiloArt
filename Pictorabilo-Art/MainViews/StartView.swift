//
//  StartView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 23.05.23.
//
// MARK: Komplett fertig

import SwiftUI

struct StartView: View {
    @State var showMenu = false //startet das MainMenu
    @State var showImpressum = false //zeigt das Impressum an
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if showMenu {
                    MainMenuView()
                }
                else if showImpressum {
                    ImpressumView(showImpressum: $showImpressum)
                }
                else {
                    Color.darkStandard.ignoresSafeArea()
                    VStack(spacing: 0){
                        GeometryReader { geo in
                            ZStack {
                                HStack {
                                    Spacer()
                                    ArtGridForStartView() //s.unten
                                    Spacer()
                                }
                                VStack {
                                    Group {
                                        Text("Strain Your Brain")
                                        Text("Pictorabilo")
                                        Text("Art")
                                    }
                                    .font(.custom("AmericamTypewriter-Bold", size: 40))
                                    .foregroundColor(.white)
                                    .padding()
                                    .shadow(color: .black, radius: 5, x: 2, y: 5)
                                    
                                    Button(action: {
                                        showMenu = true
                                    }, label:  {
                                        Image(systemName: "play.fill").font(.system(size: 90)).foregroundColor(.white)
                                         .shadow(color: .black, radius: 5, x: 2, y: 5)
                                    })
                                    
                                }
                                
                            }
                        }
                        Button(NSLocalizedString("generalInfo", comment: "genral Infos"))
                        {
                            showImpressum = true
                        }.font(.title2).foregroundColor(.lightStandard)
                        
                        if let version = appVersion {
                            Text("Version: \(version)").font(.title3).foregroundColor(.white)
                        }
                        
                    }.frame(width: geo.size.width, height: geo.size.height)
                    Spacer()
                    
                }
            }
        }
    }
}

struct ArtGridForStartView: View {
    var gridArray = arrayOfPics.shuffled()
    var body: some View {
        
        VStack(alignment: .center, spacing:  1) {
            ForEach(0..<5) { row in
                HStack(spacing:  1) {
                    ForEach(0..<5) { col in
                        Image(gridArray[row*5+col].0)//zeigt nur das Bild an, .1 wäre der Name des Künstlers, das wird im Bonusspiel gebraucht
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        }
    }
}

