//
//  THUXModelListViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 7/18/18.
//

import UIKit
import MultiModelTableViewDataSource
import Prelude
import Result
import ReactiveSwift

open class THUXModelListViewModel<T>: NSObject {
    public let dataSource = MultiModelTableViewDataSource()
    public let modelsSignal: Signal<[T], NoError>
    public let sectionsSignal: Signal<[MultiModelTableViewDataSourceSection], NoError>
    public var modelToItem: ((T) -> MultiModelTableViewDataSourceItem)
    
    public init(modelsSignal: Signal<[T], NoError>, modelToItem: @escaping (T) -> MultiModelTableViewDataSourceItem) {
        self.modelsSignal = modelsSignal
        self.modelToItem = modelToItem
        
        let transform = second(f: map, value: modelToItem) >>> MultiModelTableViewDataSourceSection.itemsToSection >>> arrayOfSingleObject
        
        self.sectionsSignal = self.modelsSignal.map(transform)
        
        super.init()
        
        self.sectionsSignal.observeValues {
            self.dataSource.sections = $0
            self.dataSource.tableView?.reloadData()
        }
    }
}

public extension MultiModelTableViewDataSourceSection {
    public static func itemsToSection(items: [MultiModelTableViewDataSourceItem]) -> MultiModelTableViewDataSourceSection {
        let section = MultiModelTableViewDataSourceSection()
        section.items = items
        return section
    }
}

public func second<U, V, X>(f: @escaping ((U, V) -> X), value: V) -> ((U) -> X) {
    return { u in f(u, value) }
}

public func map<U, V>(array: [U], f: (U) -> V) -> [V] {
    return array.map(f)
}

public func arrayOfSingleObject<T>(object: T) -> [T] {
    return [object]
}
