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

    @IBOutlet weak var brewButton: UIButton!
    var method: PreparationMethod = .drip
    var value = 0
    
    //MARK: - Actions
    
    fileprivate func setUpBrewButton() {
        brewButton.layer.borderWidth = 3.0
        brewButton.layer.borderColor = UIColor.black.cgColor
        brewButton.layer.cornerRadius = 15.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTransparentNavigationBar()
        setUpBrewButton()
    }
    
}

