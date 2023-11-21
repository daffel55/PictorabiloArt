//
//  PainterView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 11.07.23.
//MARK: NEU

import SwiftUI
/// a view that displays information about the painter and the picture
/// also a link to wikipedia about the painter, and a link to the picture in wikicommons
struct PainterView: View {
    @Binding var game : ArtGameModel
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Spacer()
                    Text("\(game.picture.artistData.artistText)\n\(game.picture.pictureData.pictureText)")
                    .font(.title)
                    .padding()
                    .border(.green, width: 2)
                    .padding()
                    .foregroundColor(.darkStandard)
                    .background(content: {Color.lightStandard})
                    .padding()
                
                Link(destination: URL(string: game.picture.artistData.getWikiLink(name: game.picture.artistData.fullName)) ?? URL(string:"https://www.google.com/?client=safari")!  , label: {
                    Text(NSLocalizedString("wikiInfo", comment: "")).underline().foregroundColor(.lightGreen).font(.title)
                })
                Link(destination: URL(string: game.picture.pictureData.picLink) ?? URL(string:"https://www.google.com/?client=safari")!, label: {
                    Text(NSLocalizedString("picInfo", comment: "")).underline().foregroundColor(.lightGreen).font(.caption)
                })
            }
        }
    }
}

