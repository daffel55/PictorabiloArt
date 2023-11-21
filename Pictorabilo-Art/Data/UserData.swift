//
//  UserData.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 21.11.23.
//MARK: NEU

import Foundation
//
//  UserData.swift
//  Pictorabilo-Art
//
//  Created by Dagmar Feldt on 06.07.23.
//MARK: NEU


import SwiftUI
/// holds the id of already played pictures (var playedPictures) and a dictionary out of those ids and an array of Strings that hold the playmodes that the user finished
/// after playing a picture the first time
struct UserData : Codable {
    
    var playedPictures : [Int] = []
    /// a dictionary with die id of a picture as key, and the already played playmodes as an array of strings
    var playedDict : [Int : [String]] = [:]
    var orderOfPics = 1
    /// Saves UserData to UserDefaults.standard
    func encodeUserData(user: UserData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "SavedUser")
        }
    }
    /// returns UserData that it tried to load from UserDefaults.standard
    /// retunrs an empty UserData if load failed
    func decoderUserData() -> UserData {
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: "SavedUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(UserData.self, from: savedPerson) {
                return loadedPerson
            }
        }
        return UserData(playedPictures: [], playedDict: [:])
        
    }
    /// updates userData or creates userData if the user wins a play mode or bonusgame for the first time
    /// this runs everytime the user wins a game or a playmode or a bonusgame
    mutating func editUserData(id: Int, mode: String) {
        if !self.playedPictures.contains(id) { // so this is the first time this level was won
            self.playedPictures.append(id) // set the first value in playedPictures
            self.playedDict[id] = ["standard"] // and set the first playmode that is played to standard
        }
        if !self.playedDict[id]!.contains(mode) { // otherwise if the current playMode is not already won
            self.playedDict[id]?.append(mode)     // register the current playmode in the playedPict
        }
        encodeUserData(user: self) //save the user
    }
    
    /// for debug purpose creates a empty user and saves this
    func resetUserData() {
        let user = UserData(playedPictures: [], playedDict:[:])
        encodeUserData(user: user)
    }
    /// for debug purpose creates a user, that already played all pictures once and syves this
    func setAllPicturesToPlayed() {
        let playedPictures = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, 21]
        let playedDict =  [0 : ["standard"], 1 : ["standard"], 2 : ["standard"],
                           3 : ["standard"], 4 : ["standard"], 5 : ["standard"],
                           6 : ["standard"], 7 : ["standard"], 8 : ["standard"],
                           9 : ["standard"], 10 : ["standard"], 11 : ["standard"],
                           12 : ["standard"], 13 : ["standard"], 14 : ["standard"],
                           15 : ["standard"], 16 : ["standard"], 17 : ["standard"],
                           18 : ["standard"], 19 : ["standard"], 20 : ["standard"],
                           21 : ["standard"]]
       
  
        let user = UserData(playedPictures: playedPictures, playedDict: playedDict)
        encodeUserData(user: user)
    }
}


enum OderOfPics : Int {
    case standard = 1
    case reversed = 2
    case unsolvedFirst = 3
    case solvedFirst = 4
}
//game.picture.id
//playmode.rawValue
