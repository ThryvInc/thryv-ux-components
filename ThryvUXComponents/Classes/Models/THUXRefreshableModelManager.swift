//
//  THUXRefreshableModelManager.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 2/11/18.
//

import UIKit
import ReactiveSwift
import Result
import FunkyNetwork

public protocol Refreshable {
    func refresh()
}

public protocol Pageable {
    func nextPage()
    func fetchPage(_ page: Int)
}

open class THUXRefreshableNetworkCallManager: Refreshable {
    open var call: NetworkCall?
    
    public init(_ call: NetworkCall) {
        self.call = call
    }
    
    open func refresh() {
        call?.fire()
    }
    
}

open class THUXPageableModelManager: THUXRefreshableNetworkCallManager, Pageable {
    open let pageProperty = MutableProperty<Int>(0)
    
    open func viewDidLoad() {
        pageProperty.signal.observeValues { page in
            if let call = self.call as? THUXPagedNetworkCall {
                call.page = page
            }
            self.call?.fire()
        }
    }
    
    open override func refresh() {
        pageProperty.value = 0
    }
    
    open func nextPage() {
        pageProperty.value = pageProperty.value + 1
    }
    
    open func fetchPage(_ page: Int) {
        pageProperty.value = page
    }
    
}
