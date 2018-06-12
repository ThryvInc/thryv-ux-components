//
//  SprintItem.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MultiModelTableViewDataSource

class SprintItem: ConcreteMultiModelTableViewDataSourceItem<SprintTableViewCell> {
    var sprint: Sprint
    
    init(_ identifier: String, _ sprint: Sprint) {
        self.sprint = sprint
        super.init(identifier: identifier)
    }
    
    override func configureCell(_ cell: UITableViewCell) {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        cell.textLabel?.text = "Sprint starting \(formatter.string(from: sprint.startDate))"
    }
    
    static func item(sprint: Sprint) -> SprintItem {
        return SprintItem("sprintCell", sprint)
    }
}
