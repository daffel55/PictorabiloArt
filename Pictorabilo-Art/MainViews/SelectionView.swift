//
//  SelctionView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 14.04.23.
//

import SwiftUI

struct SelectionView: View {
   
    //@AppStorage("selectionsNumber") var selectionsNumber = 0
    @AppStorage("instructionShown") var instructionShown = false
    @State var selectedPicture : PictureMadeOfCards = brueghelPicture
    @State var selectedArray : [Card] = brueghelPicture.cards
    @State var selectedRandomImage : String = brueghel.artistCards.randomElement()!.content.0
    
    @State var goToArtView = false
    @State var getsMoreModes = false
    
    @State var showInstructionsview = true
    @State var goToAlternative = false
    @State var goToMiniGame2 = false
    @State var withTimer = false
   
    @State var playMode = PlayMode.standardLines
    let defaults = UserDefaults.standard
    @State var idArr : [Int] = []
    var body: some View {
        if showInstructionsview && !instructionShown {
            InstructionView(shoInstructionView: $showInstructionsview, instructionHasBeenShwon: $instructionShown)
        }
        else if goToAlternative {
            BonusMiniGameView(goToAlternative: $goToAlternative)
        }
//        else if goToMiniGame2 {
//            MiniGameView(arrayOfCardsForMini2: $arrayForMini2, arrayOfCardsForMini2Large: $arrayForMini2Large, goBack: $goToArtVIew)
//        }
        
        else if  goToArtView && getsMoreModes {
            ChooseModeView(picture: $selectedPicture, imageArray: $selectedArray, withTimer: $withTimer, idArr: $idArr) //rausgenimmern: selectionsNumber: $selectionsNumber,
        } else if goToArtView && !getsMoreModes
        {
            ArtView25x25(game: ArtModel(imageArray: selectedArray, randomCard: selectedArray.randomElement()!,playmode: playMode), picture: $selectedPicture,  goToArtView: $goToArtView, playmode: $playMode, withTimer: $withTimer,idArr: $idArr) //rausgenommen: selectionsNumber: $selectionsNumber,
        } else {
            GeometryReader { geo in
                ZStack(alignment: .center) {
                    Color("SelectionBackgroundColor").ignoresSafeArea()
                    VStack(spacing: 15) { // #1
                        Text(NSLocalizedString("choose", comment: "Choose message")).foregroundColor(.white).font(.largeTitle)
                       
                        ScrollViewReader { value in
                            ScrollView(.vertical) {
                                
                                VStack { //#2
                                    ForEach(selections) { selection in
                                        Button(action: {
                                            selectedPicture = selection
                                            selectedArray = selection.cards
                                            selectedRandomImage = selection.cards.randomElement()!.content.0
                                            if idArr.contains(selection.id) {
                                                getsMoreModes = true
                                            }
                                            goToArtView = true
                                        }, label: {
                                            Image(selection.selctionImageName)
                                                .resizable()
                                                .frame(width: isInLandscape(geoWidth: geo.size.width, geoHeight: geo.size.height) ? geo.size.width / 2 : geo.size.width / 1.4)
                                                .padding(.horizontal,10)
                                                .aspectRatio(3 / 1, contentMode: .fit)
                                                .id(selection.id)
                                                .overlay(content: {
                                                    ZStack {
                                                        foreC.opacity(idArr.contains(selection.id) ? 0 : 0.9)
                                                    }.padding(.horizontal, 10)
                                                })
                                        })
                                        
                                        
                                    } // Froeach
                                    Button(action: {
                                        goToAlternative = true
                                    }, label: {
                                        Image("bonusgameSelectPic")
                                            .resizable()
                                            .frame(width: isInLandscape(geoWidth: geo.size.width, geoHeight: geo.size.height) ? geo.size.width / 2 : geo.size.width / 1.4)
                                            .padding(.horizontal,10)
                                            .aspectRatio(3 / 1, contentMode: .fit)
                                            .overlay(content: {
                                                ZStack {
                                                    foreC.opacity(selections.count == idArr.count ? 0 : 0.9)
                                                    Text(NSLocalizedString("allowBonus", comment: "Allow bonus")).font(.system(size: 20)).foregroundColor(selections.count != idArr.count ?  Color("SelectionBackgroundColor") : .clear)
                                                }.padding(.horizontal, 10)
                                            })
                                    })
                                    
                                    .disabled(idArr.count != selections.count)// button
                                } // VStack #2
                            } // Scrollview
                            
                                
                        
                            
                            
                        }
                        
                    } //VStack #1
                } //ZStack
                .onAppear(perform: {
                    idArr = defaults.object(forKey:"ids") as? [Int] ?? []

                })
            } //geometryreader
        } // else
    } //body
}
