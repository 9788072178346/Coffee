//
//  ViewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 30/06/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var coffeeLabel: UILabel!
    
    var grams = 30
    private var method: PreparationMethod = .drip
    
    private var selectedSegmentIndex = 0 {
        didSet{
            method = PreparationMethod(rawValue: selectedSegmentIndex) ?? .drip
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTransparentNavigationBar()
        updateCoffeeLabelValue(value: grams)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueToBrew else {
            return
        }
        
        guard let vc = segue.destination as? BrewController else {
            return
        }
        
        vc.grams = grams
        vc.method = method
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
        case 100:
            createAlert(title: Constants.tooMuchTitle, message: Constants.tooMuchCoffeeMessage, value: 30, includeCloseAlert: false)
            break
        default:
           break
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        selectedSegmentIndex = segmentedControl.selectedSegmentIndex
    }
}
