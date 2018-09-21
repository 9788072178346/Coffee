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
    private var method: PreparationMethod = .drip
    
    private var selectedSegmentIndex = 0 {
        didSet{
            method = PreparationMethod(rawValue: selectedSegmentIndex) ?? .drip
        }
    }
    
    private struct Constants {
        static let segueToBrew = "segueToBrew"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    setTransparentNavigationBar()
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
    
    //MARK: Custom functions
    
    func createAlert(title: String, message: String, value: Int, includeCloseAlert: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "You're right", style: .default, handler: {action in self.setGrams(value: value)}))
        if(includeCloseAlert) {
            alert.addAction(UIAlertAction(title: "I'm sure", style: .cancel, handler: nil))
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
    
    //MARK: Actions

    @IBAction func tapDown(_ sender: UIButton) {
        grams -= 1
        setGrams(value: grams)
        
        switch grams {
        case 0:
            createAlert(title: "No coffee", message: "How are you going to make coffee with no coffee?", value: 1, includeCloseAlert: false)
            break
        case 14:
           createAlert(title: "Are you sure?", message: "That is a really small amount of coffee. One cup of filter coffee usually equals 250 mililitres of water, that is 15 grams of ground coffee.", value: 15, includeCloseAlert: true)
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
            createAlert(title: "Are you sure?", message: "That is a lot of coffee. Are you seriously brewing that much at once?", value: 30, includeCloseAlert: true)
            break
        case 100:
            createAlert(title: "Too much", message: "If you're going to brew that much filter coffee at once, it won't be as good as it should be.", value: 30, includeCloseAlert: false)
            break
        default:
           break
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        selectedSegmentIndex = segmentedControl.selectedSegmentIndex
    }
}
