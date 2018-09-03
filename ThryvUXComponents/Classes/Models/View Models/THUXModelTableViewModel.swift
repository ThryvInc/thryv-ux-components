//
//  THUXModelTableViewModel.swift
//  ThryvUXComponents
//
//  Created by Elliot Schrock on 7/23/18.
//

import UIKit
import MultiModelTableViewDataSource
import Prelude
import Result
import ReactiveSwift

open class THUXModelTableViewModel<T>: THUXModelCallViewModel<T> {
    public var sectionsSignal: Signal<[MultiModelTableViewDataSourceSection], NoError>!
    public var modelToItem: ((T) -> MultiModelTableViewDataSourceItem)
    
    public init(modelsSignal: Signal<[T], NoError>, modelToItem: @escaping (T) -> MultiModelTableViewDataSourceItem) {
        self.modelToItem = modelToItem
        
        super.init(modelsSignal: modelsSignal)
        
        let transform = second(f: map, value: modelToItem) >>> MultiModelTableViewDataSourceSection.itemsToSection >>> arrayOfSingleObject
        self.sectionsSignal = self.modelsSignal.map(transform)
    }
}

public extension MultiModelTableViewDataSourceSection {
    public static func itemsToSection(items: [MultiModelTableViewDataSourceItem]) -> MultiModelTableViewDataSourceSection {
        let section = MultiModelTableViewDataSourceSection()
        section.items = items
        return section
    }
}

public func arrayOfSingleObject<T>(object: T) -> [T] {
    return [object]
}

public func second<T, U, V>(f: @escaping ((T, U) -> V), value: U) -> ((T) -> V) {
    return { u in f(u, value) }
}

public func map<U, V>(array: [U], f: (U) -> V) -> [V] {
    return array.map(f)
}
