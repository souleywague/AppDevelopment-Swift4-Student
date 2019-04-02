//
//  Game.swift
//  TheHanged
//
//  Created by Souley on 29/11/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var remainingAttempts: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            remainingAttempts -= 1 
        }
    }
}
