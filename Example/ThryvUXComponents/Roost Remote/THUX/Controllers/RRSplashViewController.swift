//
//  RRSplashViewController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents

class RRSplashViewController: THUXSplashViewController {
    var flowController: RRAppOpenFlowController!
    
    override func viewDidLoad() {
        flowController = RRAppOpenFlowController()
        viewModel = flowController.splashViewModel
        super.viewDidLoad()
        
        viewModel?.outputs.advanceAuthedSignal.observeValues({
            self.performSegue(withIdentifier: "main", sender: self)
        })
        viewModel?.outputs.advanceUnauthedSignal.observeValues({
            self.performSegue(withIdentifier: "login", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UINavigationController && (segue.destination as! UINavigationController).topViewController is RRLoginViewController {
            flowController.configureLogin(viewController: (segue.destination as! UINavigationController).topViewController as! RRLoginViewController)
        }
        if let navVC = segue.destination as? UINavigationController, let mainVC = navVC.topViewController as? RRMainViewController, segue.identifier == "main" {
            flowController.configureMain(viewController: mainVC)
        }
    }

}
