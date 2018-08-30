//
//  ViewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 30/06/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit
import Toast_Swift

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var coffeeText: UITextField!
    var segmentedControlSelection: Int = 0
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coffeeText.delegate = self
        
        self.coffeeText.keyboardType = UIKeyboardType.numberPad
        
        setNeedsStatusBarAppearanceUpdate()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BrewController {
            vc.coffeeLabelValue = coffeeText.text!
            vc.segmentedControlSelection = segmentedControlSelection
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            textField.text = "15"
            return
        }
    
        let value: Int = Int(textField.text!)!
        
        switch value {
        case 0:
            noCoffeeAlert(textField: textField)
        case (1...14):
            notEnoughCofeeAlert(textField: textField)
        case (15...45):
            return
        case (46...60):
            tooMuchCoffeeAlert()
        default:
            revertTo30(textField: textField)
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
    
    //MARK: Actions

    @IBAction func tapDown(_ sender: UIButton) {
    
        let value: Int? = Int(coffeeText.text!)!
        coffeeText.text = String(value! - 1)
        
        switch value {
        case 1:
            noCoffeeAlert(textField: coffeeText)
        case 15:
            notEnoughCofeeAlert(textField: coffeeText)
        default:
            break
        }
    }
    
    @IBAction func tapUp(_ sender: UIButton) {

        let value: Int? = Int(coffeeText.text!)!
         coffeeText.text = String(value! + 1)
        
        switch value {
        case 45:
            tooMuchCoffeeAlert()
        case 60:
            revertTo30(textField: coffeeText)
        default:
           break
        }
    }
    @IBAction func indexChanged(_ sender: Any) {
        segmentedControlSelection = segmentedControl.selectedSegmentIndex
    }
    
}

