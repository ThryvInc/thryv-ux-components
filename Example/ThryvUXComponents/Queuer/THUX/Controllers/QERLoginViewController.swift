//
//  QERLoginViewController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents

class QERLoginViewController: THUXLoginViewController {
    var flowController: QERAppOpenFlowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel?.outputs.advanceAuthed.observeValues({ (_) in
            self.performSegue(withIdentifier: "main", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController,
            let sprintsVC = navVC.topViewController as? SprintsViewController, segue.identifier == "main" {
            flowController?.navigateToMain(viewController: sprintsVC)
        }
    }

}
