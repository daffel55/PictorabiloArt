//
//  BottomButton.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 09.06.23.
//

import SwiftUI
/// makes a ZStack that is holding 'numberOfButton(Int)' at the bottom of the screen
/// buttonActions(func) and Label must be in the same order as the disired buttons
/// imagesNames are sf-symbols-names, text is the text, that is shown ("" if no text wanted)
struct BottomButton: View {
    var numberOfButton : Int
    var buttonActions : [() -> ()]
    var imageNames : [String]
    var texts : [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< numberOfButton, id: \.self) { i in
                Button(action: buttonActions[i], label: {
                        ZStack{
                            Rectangle()
                                .fill(Color.lightStandard)
                                .frame(maxWidth: .infinity, maxHeight: 85)
                                .ignoresSafeArea()
                            Label(texts[i], systemImage: imageNames[i]).textStyleLarge(deviceType: deviceType).foregroundColor(.darkStandard)
                    }
                })
            }
        }
    }
}
