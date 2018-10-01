//
//  BrewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 09/08/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class BrewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var waterNeededLabel: UILabel!
    @IBOutlet weak var brewTimeLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var grams = 30
    var water = 0
    
    var method: PreparationMethod = PreparationMethod(rawValue: Constants.pendingIndex) ?? .drip
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem!.title = ""

        setTransparentNavigationBar()
        
        updateCoffeeLabelValue(value: grams)
        
        setUpLabels()
    }
    
    //MARK: - Custom functions
    
    func createAlert(title: String, message: String, value: Int, includeCloseAlert: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Constants.defaultStyleTitle, style: .default, handler: {action in self.setGrams(value: value)}))
        if(includeCloseAlert) {
            alert.addAction(UIAlertAction(title: Constants.cancelStyleTitle, style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
    }
    
    func updateCoffeeLabelValue(value: Int) {
        coffeeLabel.text = String(value)
        evaluate()
    }
    
    func setGrams(value: Int) {
        grams = value
        updateCoffeeLabelValue(value: grams)
    }
    
    //MARK: - Actions
    
    @IBAction func tapDown(_ sender: UIButton) {
        grams -= 1
        setGrams(value: grams)
        
        switch grams {
        case 0:
            createAlert(title: Constants.noCoffeeTitle, message: Constants.noCoffeeMessage, value: 1, includeCloseAlert: false)
            break
        case 14:
            createAlert(title: Constants.areYouSureTitle, message: Constants.notEnoughCoffeeMessage, value: 15, includeCloseAlert: true)
            break
        default:
            break
        }
    }
    
    @IBAction func tapUp(_ sender: UIButton) {
        grams += 1
        setGrams(value: grams)
        
        switch grams {
        case 46:
            createAlert(title: Constants.areYouSureTitle, message: Constants.aLotOfCoffeeMessage, value: 30, includeCloseAlert: true)
            break
        case 99:
            createAlert(title: Constants.tooMuchTitle, message: Constants.tooMuchCoffeeMessage, value: 30, includeCloseAlert: false)
            break
        default:
            break
        }
    }
}

extension BrewController {
    
    fileprivate func evaluate() {
        switch method {
            case .drip, .auto:
                water = Int(round(Float(grams)*(500/30)))
            case .frenchPress:
                water = Int(round(Float(grams)*(900/60)))
        }
        
        waterLabel.text = String(water)
    }

    fileprivate func setUpLabels() {
        waterNeededLabel.text = "Water"
        brewTimeLabel.text = "Time"
        
        //Add later:
        /*ozLabel.text = "~" + String(water/28) + " oz"
        literLabel.text = "~" + String(Float(water)/1000) + " liter"*/
        
        switch method {
            case .drip:
                timeLabel.text = "3 - 4 min"
                typeLabel.text = "Drip"
            case .frenchPress:
                timeLabel.text = "4 min"
                typeLabel.text = "French Press"
            case .auto:
                timeLabel.text = "4 min"
                typeLabel.text = "Auto"
        }
    }
}
