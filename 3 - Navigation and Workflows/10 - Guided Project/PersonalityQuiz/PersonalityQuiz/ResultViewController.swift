//
//  ResultViewController.swift
//  PersonalityQuiz
//
//  Created by Souley on 13/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var totalScore: Int!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonality()
    }
    
    func calculatePersonality() {
        switch totalScore! {
        case 60...100:
            resultLabel.text = Answer.PersonalityType.dominant.definition
        case 51...60:
            resultLabel.text = Answer.PersonalityType.impulsive.definition
        case 41...50:
            resultLabel.text = Answer.PersonalityType.charming.definition
        case 31...40:
            resultLabel.text = Answer.PersonalityType.sensible.definition
        case 21...30:
            resultLabel.text = Answer.PersonalityType.fussy.definition
        case 0...21:
            resultLabel.text = Answer.PersonalityType.shy.definition
        default:
            return
        }
    }


}
