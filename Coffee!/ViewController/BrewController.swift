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
    
    var grams = 0
    var water = 0
    
    var method: PreparationMethod?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = ""

        setTransparentNavigationBar()
        
        evaluate()
        setUpLabels()
    }
}

extension BrewController {
    
    fileprivate func evaluate() {
        switch method ?? .drip {
            case .drip, .auto:
                water = Int(round(Float(grams)*(500/30)))
            case .frenchPress:
                water = Int(round(Float(grams)*(900/60)))
        }
    }

    fileprivate func setUpLabels() {
        waterNeededLabel.text = "WATER NEEDED"
        brewTimeLabel.text = "BREW TIME"
        ozLabel.text = "~" + String(water/28) + " oz"
        literLabel.text = "~" + String(Float(water)/1000) + " liter"
        waterLabel.text = String(water)
        
        switch method ?? .drip {
            case .drip:
                timeLabel.text = "3 - 4 min."
            case .frenchPress, .auto:
                timeLabel.text = "4 min."
        }
    }
}
