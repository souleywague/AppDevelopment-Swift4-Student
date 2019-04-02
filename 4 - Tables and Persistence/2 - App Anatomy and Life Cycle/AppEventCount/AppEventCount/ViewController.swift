//
//  ViewController.swift
//  AppEventCount
//
//  Created by Souley on 18/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var didFinishLaunchingLabel: UILabel!
    @IBOutlet weak var willResignActiveLabel: UILabel!
    @IBOutlet weak var didEnterBackgroundLabel: UILabel!
    @IBOutlet weak var willEnterForegroundLabel: UILabel!
    @IBOutlet weak var didBecomeActiveLabel: UILabel!
    @IBOutlet weak var willTerminateLabel: UILabel!
    
    var launchCount = Int()
    var resignCount = Int()
    var enterBackgroundCount = Int()
    var enterForegroundCount = Int()
    var becomeActiveCount = Int()
    var willTerminateCount = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func updateView() {
        didFinishLaunchingLabel.text = "The app has launched \(launchCount) times."
        willResignActiveLabel.text = "The app has resigned from active \(resignCount) times."
        didEnterBackgroundLabel.text = "The app has entered in background \(enterBackgroundCount) times."
        willEnterForegroundLabel.text = "The app has entered in foreground \(enterForegroundCount) times."
        didBecomeActiveLabel.text = "The app has became active \(becomeActiveCount) times."
        willTerminateLabel.text = "The app has terminated \(willTerminateCount) times."
    }

}

