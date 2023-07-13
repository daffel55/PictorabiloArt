//
//  ImpressumView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 22.04.23.
//


import SwiftUI

struct ImpressumView: View {
    @Binding var showImpressum : Bool
    var body: some View {
        ZStack {
            Color("HeadlineColor").ignoresSafeArea()
            VStack {
                Group {
                    HStack(alignment: .firstTextBaseline) {
                        Button(action: {
                            showImpressum = false
                        }, label: {
                            Image(systemName: "arrowshape.turn.up.backward").font(.title2)
                        }).padding(.leading,20)
                            .padding(.top, 20)
                      
                        
                        Spacer()
                       
                    }.foregroundColor(Color(.white))
                  
                    
                    
                }
                ScrollView {
                    VStack {
                        
                        Text("Impressum").font(.largeTitle).padding(.bottom, 5)
                        
                        Group {
                            Text("Dagmar Feldt").font(.title)
                            Text("c/o cobaas\nKirchenstr. 43\n24211 Preetz")
                            Text("Mail: info(at)strain-your-brain.de")
                                .foregroundColor(.white)
                                .padding(.top, 5)
                            if #available(iOS 16.0, *) {
                                Link("www.strain-your.brain.de", destination:URL(string: "http://www.strain-your-brain.de")!).foregroundColor(.white).underline()
                            } else {
                                Text("http://www.strain-your-brain-de")
                            }
                            
                        }.font(.title2)
                        Divider().overlay(.white)
                        Text(
                            NSLocalizedString("copyrightHeadline", comment: "")
                        ).font(.title).padding()
                        Text(NSLocalizedString("copyright", comment: ""))
                        Divider().overlay(.white)
                        Text(NSLocalizedString("privacy", comment: ""))
                            .font(.title)
                        Text(NSLocalizedString("privacyDeklaration", comment: "Deklaration of Privacy"))
                        
                    }.padding(.horizontal, 50)
                }
            }
        }.foregroundColor(.white)
    }
}

