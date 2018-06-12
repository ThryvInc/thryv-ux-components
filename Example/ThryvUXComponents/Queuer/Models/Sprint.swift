//
//  Sprint.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

struct Sprint {
    let startDate: Date
    
    init(startDate: Date) {
        self.startDate = startDate
    }
}

extension Sprint: Decodable {
    enum SprintKeys: String, CodingKey {
        case startDate = "start_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SprintKeys.self)
        let startDate = try container.decode(Date.self, forKey: .startDate)
        self.init(startDate: startDate)
    }
}
