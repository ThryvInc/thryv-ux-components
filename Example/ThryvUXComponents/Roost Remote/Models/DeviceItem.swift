//
//  DeviceItem.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MultiModelTableViewDataSource

class DeviceItem: ConcreteMultiModelTableViewDataSourceItem<DeviceTableViewCell> {
    var device: Device
    
    init(_ identifier: String, _ device: Device) {
        self.device = device
        super.init(identifier: identifier)
    }
    
    override func configureCell(_ cell: UITableViewCell) {
        cell.textLabel?.text = device.name
        cell.detailTextLabel?.text = device.host
    }
    
    static func item(device: Device) -> DeviceItem {
        return DeviceItem("deviceCell", device)
    }
}
