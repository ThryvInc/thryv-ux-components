//
//  THUXJsonProvider.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 10/13/18.
//

import UIKit

class THUXJsonProvider {
    public static var jsonDecoder = defaultJsonDecoder()

    public static func defaultJsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
