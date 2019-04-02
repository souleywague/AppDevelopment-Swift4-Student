//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Souley on 13/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

// Variables:
    
    var questionIndex = 0
    var numberOfPoints = 0
    
    var questions: [Question] = [
        Question(text: "1. When do you feel your best?", answers: [
            Answer(text: "In the morning", value: 2),
            Answer(text: "During the afternoon", value: 4),
            Answer(text: "Early evening", value: 4),
            Answer(text: "Late at night", value: 6)
            ]),
        
        Question(text: "2. You usually walk...", answers: [
            Answer(text: "Fairly fast, with long steps", value: 6),
            Answer(text: "Fairly fast, with short, quick steps", value: 4),
            Answer(text: "Less fast head up, looking the world in the face", value: 7),
            Answer(text: "Less fast, head down", value: 2),
            Answer(text: "Very slowly", value: 1)
            ]),
        
        Question(text: "3. When talking to people you...", answers: [
            Answer(text: "Stand with your arms folded", value: 4),
            Answer(text: "Have your hands clasped", value: 2),
            Answer(text: "Have one or both your hands on your hips", value: 5),
            Answer(text: "Touch or push the person to whom you are talking", value: 7),
            Answer(text: "Play with your ear, touch your chin, or smooth your hair", value: 6)
            ]),
        
        Question(text: "4. When relaxing, you sit with...", answers: [
            Answer(text: "Your knees bent with your legs neatly side by side", value: 4),
            Answer(text: "Your legs crossed", value: 6),
            Answer(text: "Your legs stretched out and straight", value: 2),
            Answer(text: "One leg curled under you", value: 1)
            ]),
        
        Question(text: "5. When something really amusses you, you react with...", answers: [
            Answer(text: "A big, appreciative laugh", value: 6),
            Answer(text: "A laugh, but not a loud one", value: 4),
            Answer(text: "A quiet chuckle", value: 3),
            Answer(text: "A sheepish smile", value: 2)
            ]),
        
        Question(text: "6. When you go to a party or social gathering you...", answers: [
            Answer(text: "Make a loud entrance so everyone notices you", value: 6),
            Answer(text: "Make a quiet entrance so everyone notices you", value: 4),
            Answer(text: "Make the quietest entrance, trying to stay unnoticed", value: 2)
            ]),
        
        Question(text: "7. You're working very hard and you're interrupted. Do you...", answers: [
            Answer(text: "Welcome the break", value: 6),
            Answer(text: "Feel extremely irritated", value: 2),
            Answer(text: "Vary between these two extremes", value: 4)
            ]),
        
        Question(text: "8. Which of the following colors do you like the most?", answers: [
            Answer(text: "Red or orange", value: 6),
            Answer(text: "Black", value: 7),
            Answer(text: "Yellow or light blue", value: 5),
            Answer(text: "Green", value: 4),
            Answer(text: "Dark blue or purple", value: 3),
            Answer(text: "White", value: 2),
            Answer(text: "Brown or gray", value: 1)
            ]),
        
        Question(text: "9. In those last few moments before to sleep, you lie...", answers: [
            Answer(text: "Stretched out on your back", value: 7),
            Answer(text: "Stretched out face down on your stomach", value: 6),
            Answer(text: "On your side, slightly curled", value: 4),
            Answer(text: "With your head on one arm", value: 2),
            Answer(text: "With your head under the covers", value: 1)
            ]),
        
        Question(text: "10. You often dream that you are...", answers: [
            Answer(text: "Falling", value: 4),
            Answer(text: "Fighting or struggling", value: 2),
            Answer(text: "Seraching for something or somebody", value: 3),
            Answer(text: "Flying or floating", value: 5),
            Answer(text: "You usually have dreamless sleep", value: 6),
            Answer(text: "Your dreams are always pleasant", value: 1)
            ])
    ]
    
// Outlets:
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1Label: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    
    @IBOutlet weak var answer2Label: UILabel!
    @IBOutlet weak var answer2Button: UIButton!
    
    @IBOutlet weak var answer3Label: UILabel!
    @IBOutlet weak var answer3Button: UIButton!
    
    @IBOutlet weak var answer4Label: UILabel!
    @IBOutlet weak var answer4Button: UIButton!
    
    @IBOutlet weak var answer5Label: UILabel!
    @IBOutlet weak var answer5Button: UIButton!
    
    
    @IBOutlet weak var answer6Label: UILabel!
    @IBOutlet weak var answer6Button: UIButton!
    
    
    @IBOutlet weak var answer7Label: UILabel!
    @IBOutlet weak var answer7Button: UIButton!
    
    @IBOutlet weak var submitAnswerButtonOutlet: UIButton!
    
    @IBOutlet weak var questionProgressBar: UIProgressView!
    
// LifeCycle Functions:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

// Functions:
    
    func updateUI() {
        answer1Label.isHidden = true
        answer1Button.isHidden = true
        answer1Button.isSelected = false
        answer2Label.isHidden = true
        answer2Button.isHidden = true
        answer2Button.isSelected = false
        answer3Label.isHidden = true
        answer3Button.isHidden = true
        answer3Button.isSelected = false
        answer4Label.isHidden = true
        answer4Button.isHidden = true
        answer4Button.isSelected = false
        answer5Label.isHidden = true
        answer5Button.isHidden = true
        answer5Button.isSelected = false
        answer6Label.isHidden = true
        answer6Button.isHidden = true
        answer6Button.isSelected = false
        answer7Label.isHidden = true
        answer7Button.isHidden = true
        answer7Button.isSelected = false
        submitAnswerButtonOutlet.isEnabled = false

        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressBar.setProgress(totalProgress, animated: true)
        
        switch questionIndex {
        case 0:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            
        case 1:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            answer5Label.isHidden = false
            answer5Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            answer5Label.text = currentAnswers[4].text
            
        case 2:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            answer5Label.isHidden = false
            answer5Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            answer5Label.text = currentAnswers[4].text
            
        case 3:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            
        case 4:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            
        case 5:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            
        case 6:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            
        case 7:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            answer5Label.isHidden = false
            answer5Button.isHidden = false
            answer6Label.isHidden = false
            answer6Button.isHidden = false
            answer7Label.isHidden = false
            answer7Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            answer5Label.text = currentAnswers[4].text
            answer6Label.text = currentAnswers[5].text
            answer7Label.text = currentAnswers[6].text
            
        case 8:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            answer5Label.isHidden = false
            answer5Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            answer5Label.text = currentAnswers[4].text
            
        case 9:
            answer1Label.isHidden = false
            answer1Button.isHidden = false
            answer2Label.isHidden = false
            answer2Button.isHidden = false
            answer3Label.isHidden = false
            answer3Button.isHidden = false
            answer4Label.isHidden = false
            answer4Button.isHidden = false
            answer5Label.isHidden = false
            answer5Button.isHidden = false
            answer6Label.isHidden = false
            answer6Button.isHidden = false
            
            answer1Label.text = currentAnswers[0].text
            answer2Label.text = currentAnswers[1].text
            answer3Label.text = currentAnswers[2].text
            answer4Label.text = currentAnswers[3].text
            answer5Label.text = currentAnswers[4].text
            answer6Label.text = currentAnswers[5].text
            
        default:
            return
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    
// Actions:
    @IBAction func selectionButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        var selectedButtonCount = 0
        
        sender.isSelected ? (selectedButtonCount += 1) : (selectedButtonCount -= 1)
        selectedButtonCount == 1 ? (submitAnswerButtonOutlet.isEnabled = true) : (submitAnswerButtonOutlet.isEnabled = false)
        
        switch sender.isSelected == true {
        case answer1Button.isSelected == true:
            answer2Button.isSelected = false
            answer3Button.isSelected = false
            answer4Button.isSelected = false
            answer5Button.isSelected = false
            answer6Button.isSelected = false
            answer7Button.isSelected = false
            
            
        case answer2Button.isSelected == true:
            answer1Button.isSelected = false
            answer3Button.isSelected = false
            answer4Button.isSelected = false
            answer5Button.isSelected = false
            answer6Button.isSelected = false
            answer7Button.isSelected = false
            
        case answer3Button.isSelected == true:
            answer1Button.isSelected = false
            answer2Button.isSelected = false
            answer4Button.isSelected = false
            answer5Button.isSelected = false
            answer6Button.isSelected = false
            answer7Button.isSelected = false
            
        case answer4Button.isSelected == true:
            answer1Button.isSelected = false
            answer2Button.isSelected = false
            answer3Button.isSelected = false
            answer5Button.isSelected = false
            answer6Button.isSelected = false
            answer7Button.isSelected = false
            
        case answer5Button.isSelected == true:
            answer1Button.isSelected = false
            answer2Button.isSelected = false
            answer3Button.isSelected = false
            answer4Button.isSelected = false
            answer6Button.isSelected = false
            answer7Button.isSelected = false
            
        case answer6Button.isSelected == true:
            answer1Button.isSelected = false
            answer2Button.isSelected = false
            answer3Button.isSelected = false
            answer4Button.isSelected = false
            answer5Button.isSelected = false
            answer7Button.isSelected = false
            
        case answer7Button.isSelected == true:
            answer1Button.isSelected = false
            answer2Button.isSelected = false
            answer3Button.isSelected = false
            answer4Button.isSelected = false
            answer5Button.isSelected = false
            answer6Button.isSelected = false
            
        default:
            return
        }
    }
    
    @IBAction func submitAnswerButton(_ sender: UIButton) {
        if questionIndex == 0 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[0].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[0].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[0].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[0].answers[3].value
            } 
        } else if questionIndex == 1 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[1].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[1].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[1].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[1].answers[3].value
            } else if answer5Button.isSelected == true {
                numberOfPoints += questions[1].answers[4].value
            }
        } else if questionIndex == 2 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[2].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[2].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[2].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[2].answers[3].value
            } else if answer5Button.isSelected == true {
                numberOfPoints += questions[2].answers[4].value
            }
        } else if questionIndex == 3 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[3].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[3].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[3].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[3].answers[3].value
            }
        } else if questionIndex == 4 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[4].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[4].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[4].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[4].answers[3].value
            }
        } else if questionIndex == 5 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[5].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[5].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[5].answers[2].value
            }
        } else if questionIndex == 6 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[6].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[6].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[6].answers[2].value
            }
        } else if questionIndex == 7 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[7].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[7].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[7].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[7].answers[3].value
            } else if answer5Button.isSelected == true {
                numberOfPoints += questions[7].answers[4].value
            } else if answer6Button.isSelected == true {
                numberOfPoints += questions[7].answers[5].value
            } else if answer7Button.isSelected == true {
                numberOfPoints += questions[7].answers[6].value
            }
        } else if questionIndex == 8 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[8].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[8].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[8].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[8].answers[3].value
            } else if answer5Button.isSelected == true {
                numberOfPoints += questions[7].answers[4].value
            }
        } else if questionIndex == 9 {
            if answer1Button.isSelected == true {
                numberOfPoints += questions[9].answers[0].value
            } else if answer2Button.isSelected == true {
                numberOfPoints += questions[9].answers[1].value
            } else if answer3Button.isSelected == true {
                numberOfPoints += questions[9].answers[2].value
            } else if answer4Button.isSelected == true {
                numberOfPoints += questions[9].answers[3].value
            } else if answer5Button.isSelected == true {
                numberOfPoints += questions[9].answers[4].value
            }
        }
        nextQuestion()
    }
    
// Segues:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultViewController
            resultsViewController.totalScore = numberOfPoints
        }
    }

    
}
