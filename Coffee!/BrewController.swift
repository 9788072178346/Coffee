//
//  BrewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 09/08/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class BrewController: UIViewController {
    
    
    @IBOutlet weak var literLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var ozLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var coffeeLabelValue: String = ""
    var water: Int = 0
    var segmentedControlSelection: Int!
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNeedsStatusBarAppearanceUpdate()
        
        textLabel.text = "WATER NEEDED"
        textLabel2.text = "BREW TIME"
        
        switch segmentedControlSelection {
        case 0:
            water = Int(round(Float(coffeeLabelValue)!*(500/30)))
            timeLabel.text = "3 - 4 min."
        case 1:
            water = Int(round(Float(coffeeLabelValue)!*(900/60)))
            timeLabel.text = "4 min."
        case 2:
            water = Int(round(Float(coffeeLabelValue)!*(1000/60)))
            timeLabel.text = "4 min."
        default:
            break
        }
        ozLabel.text = "~" + String(water/28) + " oz"
        literLabel.text = "~" + String(Float(water)/1000) + " liter"
        waterLabel.text = String(water)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK - Actions
    
    @IBAction func cancel(_ sender: Any) {
        navigationController!.popViewController(animated: true)
    }
}
