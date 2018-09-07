//
//  BrewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 09/08/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class BrewController: UIViewController {
    
    @IBOutlet weak var literLabel: UILabel!
    @IBOutlet weak var waterNeededLabel: UILabel!
    @IBOutlet weak var brewTimeLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var ozLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var coffeeLabelValue: String = ""
    var water: Int = 0
    var segmentedControlSelection: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = ""

        setTransparentNavigationBar()
        
        setUpCalculations()
        setUpLabels()
    }
}

extension BrewController {
    
    fileprivate func setUpCalculations() {
        switch segmentedControlSelection {
        case 0:
            water = Int(round(Float(coffeeLabelValue)!*(500/30)))
            timeLabel.text = "3 - 4 min."
        case 1:
            water = Int(round(Float(coffeeLabelValue)!*(900/60)))
            timeLabel.text = "4 min."
        case 2:
            water = Int(round(Float(coffeeLabelValue)!*(1000/60)))
            timeLabel.text = "4 min."
        default:
            break
        }
    }
    
    fileprivate func setUpLabels() {
        waterNeededLabel.text = "WATER NEEDED"
        brewTimeLabel.text = "BREW TIME"
        ozLabel.text = "~" + String(water/28) + " oz"
        literLabel.text = "~" + String(Float(water)/1000) + " liter"
        waterLabel.text = String(water)
    }
}
