//
//  DetailCardlView.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 22.05.23.
//MARK: NEU

import SwiftUI
/// a view that displayes the detail image that should be memorized and be ound at the next view
/// Paramter: game: ArtGAmeModel, playMode: PlayMode that determines whether the detail is colored or not
/// withTimer: Bool and timeInterval: Double are stored in Appstorage, these are used to show some text about the timer
struct DetailCardView: View {
    @Binding var game : ArtGameModel
    @Binding var playmode : PlayMode
    @AppStorage("timeInterval") var timeInterval = 5.0
    @AppStorage("withTimer") var withTimer = true
    var geo : GeometryProxy
    var body: some View {
        VStack {
            Group {
                Text(game.picture.artistData.fullName)
                    .font(.system(size: isIPad ? 60 : 30))
                Text(game.picture.pictureData.nameOfPicture).textStyleLarge(deviceType: deviceType)
                Text(NSLocalizedString("modDetail", comment: "modified section")).textStyleSmall(deviceType: deviceType)
            }.foregroundColor(.lightStandard)
            Spacer()
            Text(NSLocalizedString("memorize", comment: "memorize the detail")).textStyleBasic(deviceType: deviceType).foregroundColor(.marker)
            randomImage() // this is the detail card
                .resizable()
                .scaledToFit()
                .frame(width: isIPad ? 250 : 180)
                .padding(isIPad ? 20 : 10)
            Text(withTimer ? setTimerText() : NSLocalizedString("noTimer", comment: ""))
                .foregroundColor(.marker) // as you cant set the timer beyond 5.0 sec over 200 makes sure that there is no timer set
                .textStyleBasic(deviceType: deviceType)
            Text( NSLocalizedString("timerChange", comment: "where to change timer")).foregroundColor(.lightStandard).textStyleBasic(deviceType: deviceType)
        }.frame(height: geo.size.height / 1.5)
    }
    
    func randomImage() -> Image {
        switch playmode {
        case .standardLines, .reverseLines: return Image(game.randomCard.content.0)
        case .standardColor, .reverseColor: return Image(game.randomCard.content.1)
        case .bonus1, .bonus2: return Image(systemName: "circle") // placeholder so that switch is exhaustive
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
