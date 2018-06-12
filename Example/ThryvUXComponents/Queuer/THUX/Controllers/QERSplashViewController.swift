//
//  QERSplashViewController.swift
//  ThryvUXComponents
//
//  Created by Elliot on 02/10/2018.
//  Copyright (c) 2018 Elliot. All rights reserved.
//

import UIKit
import ThryvUXComponents

class QERSplashViewController: THUXSplashViewController {
    var flowController: QERAppOpenFlowController!
    
    override func viewDidLoad() {
        flowController = QERAppOpenFlowController()
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
        if segue.destination is UINavigationController && (segue.destination as! UINavigationController).topViewController is QERLoginViewController {
            flowController.navigateToLogin(viewController: (segue.destination as! UINavigationController).topViewController as! QERLoginViewController)
        }
        if let navVC = segue.destination as? UINavigationController, let sprintsVC = navVC.topViewController as? SprintsViewController, segue.identifier == "main" {
            flowController.navigateToMain(viewController: sprintsVC)
        }
    }
}
