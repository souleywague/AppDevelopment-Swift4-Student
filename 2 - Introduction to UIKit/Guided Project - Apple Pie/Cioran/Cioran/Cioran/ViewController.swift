//
//  ViewController.swift
//  Cioran
//
//  Created by Souley on 28/11/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageNumber = 0
    
    var rebuSolutions = ["L'amertume des entrailles.",
                           "Ballotté entre le cynisme et l'élégie.",
                           "L'espoir est la forme normale du délire.",
                           "L'esprit: cumul des disgrâces.",
                           "Avec Bach, la vie serait supportable, même dans un égout.",
                           "C'est en mouchard que j'ai rôdé autour de Dieu; incapable de l'implorer, je l'ai espionné."
                        ]
    
    @IBOutlet weak var rebuImages: UIImageView!
    @IBOutlet weak var rebuSolutionsLabel: UILabel!
    @IBOutlet weak var showSolutionButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func showSolutionAction(_ sender: UIButton) {
        rebuSolutionsLabel.text = rebuSolutions[Int("\(imageNumber - 1)")!]
        enterButton.isEnabled = true
        showSolutionButton.isEnabled = false
    }
    
    @IBAction func enterButtonAction(_ sender: UIButton) {
        if !showSolutionButton.isHidden {
            updateUI()
            showSolutionButton.isEnabled = true
        } else {
            playAgain()
        }
    }
    
    func updateUI() {
        if  imageNumber != rebuSolutions.count {
            imageNumber += 1
            rebuImages.image = UIImage(named: "Cioran \(imageNumber)")
            rebuSolutionsLabel.text = "???"
            enterButton.isEnabled = false
        } else if imageNumber == rebuSolutions.count {
            rebuSolutionsLabel.text = "Finished! Wanna Play Again?"
            rebuImages.image = nil
            showSolutionButton.isHidden = true
        }
    }
    
    func playAgain() {
        enterButton.isEnabled = true
        showSolutionButton.isHidden = false
        imageNumber = 0
        updateUI()
    }
    
    
}

