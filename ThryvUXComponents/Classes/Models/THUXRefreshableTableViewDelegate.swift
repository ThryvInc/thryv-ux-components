//
//  THUXRefreshableTableViewDelegate.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 6/9/18.
//

import UIKit

open class THUXRefreshableTableViewDelegate: NSObject, UITableViewDelegate {
    open var refreshableModelManager: THUXRefreshableModelManager?
    open var pageSize: Int = 20
    open var pageTrigger: Int = 5
    
    public init(_ refreshableModelManager: THUXRefreshableModelManager?) {
        self.refreshableModelManager = refreshableModelManager
    }

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row % pageSize == pageSize - pageTrigger {
            refreshableModelManager?.nextPage()
        }
    }
}
