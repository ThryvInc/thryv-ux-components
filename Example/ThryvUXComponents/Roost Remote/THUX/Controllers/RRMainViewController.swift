//
//  RRMainViewController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents

class RRMainViewController: THUXRefreshablePagedTableViewController {
    var viewModel: RRDeviceViewModel? {
        didSet {
            if let viewModel = viewModel {
                refreshableModelManager = THUXRefreshableModelManager(viewModel.call)
                refreshableTableViewDelegate = THUXRefreshableTableViewDelegate(refreshableModelManager)
                
                viewModel.dataSource.tableView = self.tableView
                tableView.dataSource = viewModel.dataSource
                
                refreshableModelManager?.viewDidLoad()
                refreshableModelManager?.refresh()
            }
        }
    }
}
