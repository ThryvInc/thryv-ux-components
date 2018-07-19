//
//  THUXTextValidator.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 7/18/18.
//

import UIKit

public protocol THUXTextValidatorProtocol {
    var invalidText: String { get }
    func isTextValid(text: String) -> Bool
}

open class THUXNotEmptyTextValidator: THUXTextValidatorProtocol {
    public let invalidText: String = "Cannot be empty"
    
    open func isTextValid(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
}

open class THUXLengthTextValidator: THUXTextValidatorProtocol {
    open let length: Int
    public var invalidText: String {
        get {
            return "Must be at least \(self.length) characters long"
        }
    }
    
    init(length: Int) {
        self.length = length
    }
    
    open func isTextValid(text: String) -> Bool {
        return text.count > length
    }
}

open class THUXEmailTextValidator: THUXTextValidatorProtocol {
    let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" + "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
    public let invalidText: String = "Not a valid email"
    
    
    open func isTextValid(text: String) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
}
