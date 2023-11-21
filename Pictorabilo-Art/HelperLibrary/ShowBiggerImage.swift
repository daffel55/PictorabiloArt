//
//  ShowBiggerImage.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 13.07.23.
//

import SwiftUI
/// a View that show a magnified version of a detail card when s long press gesture was detected
struct ShowBiggerImage: View {
    @Binding var nameOfImageToZoom : String
    @Binding var control : GameViewControl
    @Binding var showBigger : Bool
    // the next two parameter ar used to make the view dragggable and return to center after drag
    @State private var off :CGSize = CGSize(width: 0.0,height: 0.0)
    @State private var viewState = CGSize.zero
    var body: some View {
        Image(nameOfImageToZoom)
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .shadow(color: .black, radius: 15, x: 10, y: 2)
            .offset(x: viewState.width, y: viewState.height)
                        .gesture(
                            DragGesture().onChanged { value in
                                viewState = value.translation
                            }
                            .onEnded { value in
                                withAnimation(.spring()) {
                                    viewState = .zero
                                }
                            }
                        )
            .onTapGesture {
                control.allowTap = true
                //allowtap was set to false with showing the biggerView, it must set tu true again to continue the game
                showBigger = false
            }
    }
}


