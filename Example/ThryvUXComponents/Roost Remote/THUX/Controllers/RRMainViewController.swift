//
//  RRMainViewController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents

class RRMainViewController: THUXPageableTableViewController {
    var viewModel: RRDeviceViewModel? {
        didSet {
            if let viewModel = viewModel {
                pageableModelManager = THUXPageableModelManager(viewModel.call)
                pageableTableViewDelegate = THUXPageableTableViewDelegate(pageableModelManager)
                
                viewModel.dataSource.tableView = self.tableView
                tableView.dataSource = viewModel.dataSource
                
                pageableModelManager?.viewDidLoad()
                refreshableModelManager?.refresh()
            }
        }
    }
}
