//
//  THUXRefreshablePagedTableViewController.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 6/9/18.
//

import UIKit

open class THUXRefreshablePagedTableViewController: UIViewController {
    @IBOutlet public var tableView: UITableView!
    open var refreshableModelManager: THUXRefreshableModelManager? {
        didSet {
            refreshableModelManager?.call?.responseSignal.observeValues({ _ in
                self.tableView.refreshControl?.endRefreshing()
            })
        }
    }
    open var refreshableTableViewDelegate: THUXRefreshableTableViewDelegate?
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.delegate = refreshableTableViewDelegate
        
        refreshableModelManager?.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    @objc
    open func refresh() {
        if let isRefreshing = tableView.refreshControl?.isRefreshing, !isRefreshing {
            tableView.refreshControl?.beginRefreshing()
        }
        refreshableModelManager?.refresh()
    }

}
