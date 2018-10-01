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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTransparentNavigationBar()
        
        brewButton.layer.borderWidth = 3.0
        brewButton.layer.borderColor = UIColor.black.cgColor
        brewButton.layer.cornerRadius = 15.0
        
    }
    
}

