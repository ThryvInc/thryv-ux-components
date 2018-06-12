//
//  QERAuthResponse.swift
//  ThryvUXComponents_Example
//
//  Created by Elliot Schrock on 6/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

struct QERAuthResponse {
    let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
}

extension QERAuthResponse: Decodable {
    enum AuthKeys: String, CodingKey {
        case apiKey = "api_key"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AuthKeys.self)
        let apiKey = try container.decode(String.self, forKey: .apiKey)
        self.init(apiKey: apiKey)
    }
}
