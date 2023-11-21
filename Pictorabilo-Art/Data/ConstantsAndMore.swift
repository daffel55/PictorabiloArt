//
//  ConstantsAndMore.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 23.05.23.
//MARK: NEU

import SwiftUI

extension Color {
    static let lightStandard = Color("LightStandard")
    static let darkStandard = Color("DarkStandard") // war #5F7485
    static let marker = Color("Marker")
    static let lightGreen = Color("LightGreen")
    static let lightOrange = Color("Color_orange")
}


class GameConstants {
    /// maxJoker = 3
    static let maxJoker = 3
    /// backtext (back, zurück: locallized)
    static let backText = NSLocalizedString("back", comment: "")
    /// instruction text localized
    static let instructText = NSLocalizedString("instruction", comment: "")
    /// the word setting localized
    static let settingsText = NSLocalizedString("settings", comment: "")
    /// arrowshap.turn.up.left
    static let backImage = "arrowshape.turn.up.left"
    /// info.circle
    static let infoImage = "info.circle"
    /// gearshape
    static let settingsImage = "gearshape"
    
    
}
/// gives UIDevice.current.localizedModel
var deviceType = UIDevice.current.localizedModel
/// true if current device is iPad
var isIPad : Bool {
    deviceType == "iPad"
}


/// font on iPad .title. other .title2
struct TextStyleBasic : ViewModifier {
    var deviceType : String
    func body(content: Content) -> some View {
        if deviceType == "iPad" {
            content.font(.title)
        } else {
            content.font(.title2)
        }
    }
}
/// font on iPad .title. other .title2
extension View {
    func textStyleBasic(deviceType : String) -> some View {
        modifier(TextStyleBasic(deviceType: deviceType))
    }
}

/// font on iPad .largeTitle. other .title
struct TextStyleLarge : ViewModifier {
    var deviceType : String
    func body(content: Content) -> some View {
        if deviceType == "iPad" {
            content.font(.system(.largeTitle))
        } else {
            content.font(.title)
        }
    }
}
/// font on iPad .largeTitle. other .title
extension View {
    func textStyleLarge(deviceType : String) -> some View {
        modifier(TextStyleLarge(deviceType: deviceType))
    }
}
/// font on iPad .title2. other .title3
struct TextStyleSmall : ViewModifier {
    var deviceType : String
    func body(content: Content) -> some View {
        if deviceType == "iPad" {
            content.font(.title2)
        } else {
            content.font(.title3)
        }
    }
}
/// font on iPad .title2. other .title3
extension View {
    func textStyleSmall(deviceType : String) -> some View {
        modifier(TextStyleSmall(deviceType: deviceType))
    }
}

enum PlayMode : String {
    /// detail lines, picture lines
    case standardLines = "standard"
    /// detail color, picture color
    case standardColor = "easy"
    /// detail color, picture lines
    case reverseColor = "tricky"
    /// detail lines, picture color
    case reverseLines = "hard"
    case bonus1 = "bonus1"
    case bonus2 = "bonus2"
}

