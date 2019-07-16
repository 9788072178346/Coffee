//
//  ViewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 30/06/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    // MARK: - Properties

    @IBOutlet weak var brewButton: UIButton!
    @IBOutlet weak var methodLabel: UILabel!
    
    var method: PreparationMethod = .drip
    var value = 0
    
    // MARK: - Actions
    
    fileprivate func setUpBrewButton() {
        brewButton.layer.borderWidth = 3.0
        brewButton.layer.borderColor = UIColor.black.cgColor
        brewButton.layer.cornerRadius = 20.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(0, forKey: Constants.indexKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeMethodLabel), name: Notification.Name(".pageTransitionOccured"), object: nil)
        
        setTransparentNavigationBar()
        setUpBrewButton()
    }
    
    // MARK: - Custom functions
    
    @objc func changeMethodLabel() {
        
        let currentIndex = UserDefaults.standard.integer(forKey: Constants.indexKey)
        
        switch currentIndex {
        case 0:
            methodLabel?.text = Constants.frenchPress
        default:
            methodLabel?.text = Constants.drip
        }
    }
}
