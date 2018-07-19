//
//  THUXModelsCall.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 7/18/18.
//

import UIKit

open class THUXModelCall<T>: THUXPagedNetworkCall where T: Decodable {
    open lazy var modelSignal = dataSignal.skipNil().map(parseDecodable).skipNil()
    
    func parseDecodable(json: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: json)
            return result
        } catch {
            print("\(error)")
            return nil
        }
    }
}
