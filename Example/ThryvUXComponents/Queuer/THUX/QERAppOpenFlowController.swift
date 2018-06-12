//
//  QERAppOpenFlowController.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import ThryvUXComponents
import MultiModelTableViewDataSource
import Prelude

class QERAppOpenFlowController: THUXAppOpenFlowController {
    override init() {
        super.init()
        setupSplash()
        setupLogin()
    }
    
    func setupSplash() {
        THUXSessionManager.session = THUXUserDefaultsSession(authDefaultsKey: "qerApiKey", authHeaderKey: "X-Qer-Authorization")
        splashViewModel = THUXSplashViewModel(minimumVisibleTime: 0.0, otherTasks: nil)
    }
    
    func setupLogin() {
        loginViewModel = THUXLoginViewModel(credsCall: QERCredsLoginNetworkCall())
    }
    
    func navigateToLogin(viewController: QERLoginViewController) {
        viewController.flowController = self
        viewController.loginViewModel = loginViewModel
    }
    
    func navigateToMain(viewController: SprintsViewController) {
        let dataSource = MultiModelTableViewDataSource()
        
        let transform = QERAppOpenFlowController.sprintItemsFromSprints
            >>> MultiModelTableViewDataSourceSection.itemsToSection
            >>> arrayOfSingleObject
        
        let call = GetSprintsCall()
        let sprintItemSignal = call.sprintsSignal.map(transform)
        sprintItemSignal.observeValues {
            dataSource.sections = $0
            dataSource.tableView?.reloadData()
        }
        
        viewController.refreshableModelManager = THUXRefreshableModelManager(call)
        viewController.refreshableTableViewDelegate = THUXRefreshableTableViewDelegate(viewController.refreshableModelManager)
        viewController.dataSource = dataSource
    }
    
    static func sprintItemsFromSprints(sprints: [Sprint]) -> [SprintItem] {
        return sprints.map(SprintItem.item)
    }
}

extension MultiModelTableViewDataSourceSection {
    static func itemsToSection(items: [MultiModelTableViewDataSourceItem]) -> MultiModelTableViewDataSourceSection {
        let section = MultiModelTableViewDataSourceSection()
        section.items = items
        return section
    }
}

func arrayOfSingleObject<T>(object: T) -> [T] {
    return [object]
}
