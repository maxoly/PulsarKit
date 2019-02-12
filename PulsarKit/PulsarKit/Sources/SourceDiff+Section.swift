//
//  SourceDiff+Section.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 14/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

// MARK: - Internal
internal extension SourceDiff where Element == SourceSection {
    func recursiveReset() {
        reset()
        current.forEach { $0.models.reset() }
    }
}

// MARK: - Section Add/Insert
public extension SourceDiff where Element == SourceSection {
    @discardableResult
    func add() -> SourceSection {
        let section = SourceSection()
        add(element: section)
        return section
    }
    
    @discardableResult
    func add(quantity: Int) -> [SourceSection] {
        var created = [SourceSection]()
        for _ in 1...quantity {
            created.append(SourceSection())
        }
        
        add(elements: created)
        return created
    }
    
    @discardableResult
    func insert(at index: Int) -> SourceSection {
        let section = SourceSection()
        insert(element: section, at: index)
        return section
    }
    
    @discardableResult
    func insert(in range: ClosedRange<Int>) -> [SourceSection] {
        var result = [SourceSection]()
        range.forEach {
            let section = SourceSection()
            result.append(section)
            insert(element: section, at: $0)
        }
        
        return result
    }
}
