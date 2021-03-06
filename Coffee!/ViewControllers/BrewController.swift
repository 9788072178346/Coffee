//
//  BrewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 09/08/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class BrewController: UIViewController {
        
    @IBOutlet weak var typeBrewLabel: UILabel!
    @IBOutlet weak var aboutBrewMethodLabel: UILabel!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var waterNeededLabel: UILabel!
    @IBOutlet weak var brewTimeLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var grams = 30
    var water = 0
    
    var method: PreparationMethod = .drip
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentIndex = UserDefaults.standard.integer(forKey: Constants.indexKey)
        method = PreparationMethod(rawValue: currentIndex)!
                
        navigationController!.navigationBar.topItem!.title = ""

        setTransparentNavigationBar()
        
        updateCoffeeLabelValue(value: grams)
        
        setUpLabels()
    }
    
    // MARK: - Custom functions
    
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
    
    // MARK: - Actions
    
    @IBAction func tapDown(_ sender: UIButton) {
        grams -= 1
        setGrams(value: grams)
        
        switch grams {
        case 0:
            createAlert(title: Constants.noCoffeeTitle, message: Constants.noCoffeeMessage, value: 1, includeCloseAlert: false)
        case 14:
            createAlert(title: Constants.areYouSureTitle, message: Constants.notEnoughCoffeeMessage, value: 15, includeCloseAlert: true)
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
        case 99:
            createAlert(title: Constants.tooMuchTitle, message: Constants.tooMuchCoffeeMessage, value: 30, includeCloseAlert: false)
        default:
            break
        }
    }
}

extension BrewController {
    
    fileprivate func evaluate() {
        switch method {
            case .drip:
                water = Int(round(Float(grams)*(500/30)))
            case .frenchPress:
                water = Int(round(Float(grams)*(900/60)))
        }
        
        waterLabel.text = String(water)
    }

    fileprivate func setUpLabels() {
        waterNeededLabel.text = "Water"
        brewTimeLabel.text = "Time"
        
        switch method {
            case .drip:
                timeLabel.text = "3 - 4 min"
                typeBrewLabel.text = "Pour-over"
                aboutBrewMethodLabel.text = Constants.aboutDrip
            case .frenchPress:
                timeLabel.text = "4 min"
                typeBrewLabel.text = "French Press"
                aboutBrewMethodLabel.text = Constants.aboutFrenchPress
        }
    }
}
