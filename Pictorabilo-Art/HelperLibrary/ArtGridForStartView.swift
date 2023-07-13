//
//  ArtGrid.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 26.04.23.
//

import SwiftUI

struct ArtGridForStartView: View {
   var gridArray = artArray
    var body: some View {

        VStack(alignment: .center, spacing:  1) {
        
        ForEach(0..<5) { row in
            HStack(spacing:  1) {
                ForEach(0..<5) { col in
                    Image(gridArray[row*5+col])
                        .resizable()
                        .scaledToFit()
                   
                        
                        
                       
                }
            }
        }
   
    }
    }
}

var artArray : [String] {
    var arr : [String] = []
    var theSet : Set<String> = []
    
    while theSet.count < 25 {
        theSet.insert(arrayOfPics.randomElement()!.0)
    }
    arr = Array(theSet)
    return arr
}





//let theSet = Set(startPic)
//arr = Array(theSet)
