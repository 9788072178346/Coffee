//
//  ViewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 30/06/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var coffeeLabel: UILabel!
    
    var grams = 30
    var segmentedControlSelection = 0
    
    private struct Constants {
        static let segueToBrew = "segueToBrew"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    setTransparentNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueToBrew, let vc = segue.destination as? BrewController, let grams = coffeeLabel.text {
            vc.coffeeLabelValue = grams
            vc.segmentedControlSelection = segmentedControlSelection
        }
    }
    
    //MARK: Custom functions
    
    func noCoffeeAlert(textField: UITextField) {
        let alert = UIAlertController(title: "No Coffee", message: "How are you going to make coffee with no coffee?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Right", style: .default, handler: { action in textField.text = "1"}))
        self.present(alert, animated: true)
    }
    
    func notEnoughCofeeAlert(textField: UITextField) {
        let alert = UIAlertController(title: "Are you sure?", message: "That is a really small amount of coffee. One cup of filter coffee usually equals 250 mililitres of water, that is 15 grams of ground coffee.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "You're right", style: .default, handler: { action in textField.text = "15"}))
        alert.addAction(UIAlertAction(title: "I'm sure", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func tooMuchCoffeeAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: "That is a lot of coffee. Are you seriously brewing that much at once?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "I'm sure", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func revertTo30(textField: UITextField) {
        let alert = UIAlertController(title: "Seriously?", message: "You must be kidding, right?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Right", style: .cancel, handler: {action in textField.text = "30"}))
        self.present(alert, animated: true)
    }
    
    func createAlert(title: String, message: String, style: UIAlertControllerStyle, alertTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        alert.addAction(UIAlertAction(title: alertTitle, style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func updateCoffeeLabelValue(value: Int) {
        coffeeLabel.text = String(value)
    }
    
    //MARK: Actions

    @IBAction func tapDown(_ sender: UIButton) {
        grams -= 1
        updateCoffeeLabelValue(value: grams)
        
        switch grams {
        case 1:
            // no coffee
            break
        case 15:
           // not enough coffee
            break
        default:
            break
        }
    }
    
    @IBAction func tapUp(_ sender: UIButton) {
        grams += 1
        updateCoffeeLabelValue(value: grams)
        
        switch grams {
        case 45:
            // too much coffee
            break
        case 60:
            // revert to more sensible option
            break
        default:
           break
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        segmentedControlSelection = segmentedControl.selectedSegmentIndex
    }
}
