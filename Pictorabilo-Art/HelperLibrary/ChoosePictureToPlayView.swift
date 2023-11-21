//
//  ChoosePictureToPlayView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 08.07.23.
//MARK: NEU
import SwiftUI
/// description:  holds all available pictures plus bonus game and leads to artgame with selected picture as parameter
/// parameter: game: ArtGameModel, gotoArtGame: Bool, geo: GeometryProxy, user: UserData, gotoBonusGame: Bool
struct ChoosePictureToPlayView: View {
    @Binding var game : ArtGameModel
    @Binding var gotoArtGame : Bool
    var geo : GeometryProxy
    @Binding var user : UserData
    @Binding var gotoBonusGame : Bool
    
    @State var picsToChoose = selections
    
    var body: some View {
        VStack { //VStack #1
            HStack {
                Text(NSLocalizedString("choose", comment: "Choose message")).foregroundColor(.white).font(.largeTitle)
                Spacer()
                Menu {
                    Button(NSLocalizedString("sortOrderStandard", comment: "")) {
                        user.orderOfPics = 1
                        user.encodeUserData(user: user)
                        picsToChoose = selections
                    }
                    Button(NSLocalizedString("newestFirst", comment: "")) {
                        user.orderOfPics = 2
                        user.encodeUserData(user: user)
                        picsToChoose = selections.reversed()
                    }
                    Button(NSLocalizedString("unsolvedFirst", comment: "")) {
                        user.orderOfPics = 3
                        user.encodeUserData(user: user)
                        picsToChoose = sortUnSolvedFirst().reversed()
                    }
                    Button(NSLocalizedString("solvedFirst", comment: "")) {
                        user.orderOfPics = 4
                        user.encodeUserData(user: user)
                        picsToChoose = sortUnSolvedFirst()
                    }
                } label: {
                    Label("", systemImage: "line.3.horizontal.decrease.circle").textStyleLarge(deviceType: deviceType).foregroundColor(.lightStandard)
                }
            }.frame(width: isIPad ? geo.size.width / 2 : geo.size.width / 1.4)
            ScrollViewReader { value in
                ScrollView(.vertical) {
                    /// LazyVStack shows all Pictures first, if picture already played without white overlay
                    /// every picture is a button that leads to ArtGame with that picture selected
                    LazyVStack { //#2
                        ForEach(picsToChoose) { selection in
                            Button(action: {
                                game = ArtGameModel(picture: selection)
                                gotoArtGame = true}
                                   , label: {
                                Image(selection.selectionImageName)
                                    .resizable()
                                    .aspectRatio(3 / 1, contentMode: .fit)
                                    .frame(width: isIPad ? geo.size.width / 2 : geo.size.width / 1.4)
                                    .padding(.horizontal,10)
                                    .id(selection.id)
                                    .overlay(content: {
                                        ZStack {
                                            Color.lightStandard.opacity(user.playedPictures.contains(selection.id) ? 0 : 0.9)
                                        }.padding(.horizontal, 10)
                                    })
                            })
                        } // FroEach
                        ///The last button leads to bonus game, that is only available when all pictures are played at least once
                        Button(action: {
                            gotoBonusGame = true
                        }, label: {
                            Image("bonusgameSelectPic")
                                .resizable()
                                .aspectRatio(3 / 1, contentMode: .fit)
                                .frame(width: isIPad ? geo.size.width / 2 : geo.size.width / 1.4)
                                .padding(.horizontal,10)
                                .aspectRatio(3 / 1, contentMode: .fit)
                                .overlay(content: {
                                    ZStack {
                                        Color.lightStandard.opacity(selections.count == user.playedPictures.count ? 0 : 0.9)
                                        Text(NSLocalizedString("allowBonus", comment: "Allow bonus")).font(.system(size: 20)).foregroundColor(selections.count != user.playedPictures.count ?  Color("SelectionBackgroundColor") : .clear)
                                    }.padding(.horizontal, 10)
                                })
                        })
                        .disabled(user.playedPictures.count != selections.count)// button
                    } // VStack #2
                } // Scrollview
            }
        }
        .onAppear(perform: {
            savedOrderOfPics()
        })
    }
    
    func savedOrderOfPics() {
        switch user.orderOfPics {
        case 1: picsToChoose = selections
        case 2: picsToChoose = selections.reversed()
        case 3: picsToChoose = sortUnSolvedFirst().reversed()
        case 4: picsToChoose = sortUnSolvedFirst()
        default: picsToChoose = selections
        }
    }
    
    func sortUnSolvedFirst() -> [PictureMadeOfCards] {
        var solvedPics = [PictureMadeOfCards]()
        let solvedIds = user.playedPictures
        for pic in picsToChoose {
            if solvedIds.contains(pic.id) {
                solvedPics.append(pic)
            }
        }
        for pic in picsToChoose {
            if !solvedIds.contains(pic.id) {
                solvedPics.append(pic)
            }
        }
        return solvedPics
    }
}


