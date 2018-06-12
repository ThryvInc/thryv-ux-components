//
//  RRLoginViewController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents

class RRLoginViewController: THUXLoginViewController {
    var flowController: RRAppOpenFlowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel?.outputs.advanceAuthed.observeValues({ (_) in
            self.performSegue(withIdentifier: "main", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController, let mainVC = navVC.topViewController as? RRMainViewController, segue.identifier == "main" {
            flowController?.configureMain(viewController: mainVC)
        }
    }
}
