//
//  SprintsViewController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import MultiModelTableViewDataSource

class SprintsViewController: THUXRefreshablePagedTableViewController {
    var dataSource: MultiModelTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource?.tableView = self.tableView
        tableView.dataSource = dataSource
    }
}
