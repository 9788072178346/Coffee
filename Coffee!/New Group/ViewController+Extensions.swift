//
//  ViewController+Extensions.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 07/09/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setTransparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
