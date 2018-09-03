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

class SprintsViewController: THUXPageableTableViewController {
    var dataSource: MultiModelTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource?.tableView = self.tableView
        tableView.dataSource = dataSource
        
        pageableModelManager?.viewDidLoad()
        pageableModelManager?.call?.errorSignal.observeValues({ (error) in
            self.tableView.refreshControl?.endRefreshing()
        })
    }
}
