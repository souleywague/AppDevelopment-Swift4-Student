//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by Souley on 23/12/2018.
//

import UIKit

class AthleteFormViewController: UIViewController {

    var athlete: Athlete?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var leagueTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let athlete = athlete else { return }
        nameTextField.text = athlete.name
        ageTextField.text = athlete.age
        leagueTextField.text = athlete.league
        teamTextField.text = athlete.team
    }

    @IBAction func saveButton(_ sender: UIButton) {
        guard let name = nameTextField.text,
            let age = ageTextField.text,
            let league = leagueTextField.text,
            let team = teamTextField.text else { return }
        
        athlete = Athlete(name: name, age: age, league: league, team: team)
        
        performSegue(withIdentifier: "unwindToAthlete", sender: self)
    }
}
