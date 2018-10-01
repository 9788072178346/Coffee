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
    
    private var method: PreparationMethod = .drip
    
    private var selectedSegmentIndex = 0 {
        didSet{
            method = PreparationMethod(rawValue: selectedSegmentIndex) ?? .drip
        }
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
        
        vc.method = method
        }
    
    //MARK: - Custom functions
    
    //MARK: - Actions
    
    @IBAction func indexChanged(_ sender: Any) {
        selectedSegmentIndex = segmentedControl.selectedSegmentIndex
    }
}

