//
//  StartView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 21.04.23.
//

import SwiftUI


struct StartView : View {
    
    
    let gridItems = [GridItem(.flexible(minimum: 50, maximum: 120)), GridItem(.flexible(minimum: 50, maximum: 120)), GridItem(.flexible(minimum: 50, maximum: 120)), GridItem(.flexible(minimum: 50, maximum: 120)), GridItem(.flexible(minimum: 50, maximum: 120)), GridItem(.flexible(minimum: 50, maximum: 120)),]
    @State var showMenu = false
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    @State var showImpressum = false
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if showMenu {
                   SelectionView()
                }
                else if showImpressum {
                    ImpressumView(showImpressum: $showImpressum)
                }
                else {
                    Color(.black).ignoresSafeArea()
                    
                        VStack(spacing: 0){
                            
                            
                            GeometryReader { geo in
                                ZStack {
                                    HStack {
                                        Spacer()
                                        
                                        ArtGridForStartView()
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
                            }.font(.title2).foregroundColor(foreC)
                            
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





