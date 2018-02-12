//
//  THUXSplashViewController.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/10/18.
//

import UIKit

class THUXSplashViewController: UIViewController {
    var viewModel: SplashProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.inputs.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.inputs.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.inputs.viewDidAppear()
    }

}
