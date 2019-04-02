//
//  ViewController.swift
//  TheHanged
//
//  Created by Souley on 29/11/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables and Constants:
    var guessedWordsList = [String]()
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var numberOfGuessingAttemptsAllowed = 10
    
    var currentGame: Game!
    
    // Outlets:
    @IBOutlet weak var scoreWins: UILabel!
    @IBOutlet weak var scoreLosses: UILabel!
    
    @IBOutlet weak var hangedImageView: UIImageView!
    @IBOutlet weak var guessedWord: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var guessedWordEntry: UITextField!
    @IBOutlet weak var guessedWordEnterButton: UIButton!
    
    // viewDidLoad Function:
    override func viewDidLoad() {
        super.viewDidLoad()
        wordEntryStage()
    }
    
    // Functions:
    func wordEntryStage() {
        hangedImageView.isHidden = true
        for button in letterButtons {
            button.isHidden = true
        }
        switch guessedWordsList.count {
        case 0:
            guessedWord.text = "PLEASE ENTER YOUR 5 WORDS!"
        case 1:
            guessedWord.text = "4 WORDS LEFT!"
        case 2:
            guessedWord.text = "3 WORDS LEFT!"
        case 3:
            guessedWord.text = "2 WORDS LEFT!"
        case 4:
            guessedWord.text = "1 WORDS LEFT!"
        default:
            guessedWord.text = "PRESS ENTER!"
        }
    }
    
    func startGame() {
        hangedImageView.isHidden = false
        for button in letterButtons {
            button.isHidden = false
        }
        guessedWordEntry.isHidden = true
        guessedWordEnterButton.isHidden = true
        newRound()
    }
    
    func newRound() {
        if guessedWordsList.isEmpty {
            restartGame()
        } else {
            let wordToBeGuessed = guessedWordsList.removeFirst()
            currentGame = Game(word: wordToBeGuessed, remainingAttempts: numberOfGuessingAttemptsAllowed, guessedLetters: [])
            guessedWord.text = wordToBeGuessed
            
            for buttons in letterButtons {
                buttons.isEnabled = true
                buttons.alpha = 1
            }
            updateUI()
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        guessedWord.text = wordWithSpacing
        scoreWins.text = "WINS: \(totalWins)"
        scoreLosses.text = "LOSSES: \(totalLosses)"
        hangedImageView.image = UIImage(named: "Hanged \(currentGame.remainingAttempts)")
    }
    
    func updateGameState() {
        if currentGame.remainingAttempts == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func restartGame() {
        hangedImageView.isHidden = true
        guessedWordEntry.isHidden = false
        guessedWordEnterButton.isHidden = false
        wordEntryStage()
    }
    
    // Action functions:
    @IBAction func guessedWordEntryActionButton(_ sender: UIButton) {
        let wordEntered: String = "\(guessedWordEntry.text!)".uppercased()
        if guessedWordsList.count < 5 && !(guessedWordEntry.text?.isEmpty)! {
            guessedWordsList.append(wordEntered)
            guessedWordEntry.text = nil
            wordEntryStage()
        } else if guessedWordsList.count == 5 {
            startGame()
        } else {
            guessedWord.text = "Please enter your word."
        }
    }
    
    @IBAction func letterButtonsAction(_ sender: UIButton) {
        sender.isEnabled = false
        sender.alpha = 0.5
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.uppercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
}

