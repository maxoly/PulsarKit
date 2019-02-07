//
//  SourceDiff.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation

public final class SourceDiff<Element: Hashable> {
    // private
    private lazy var added: [Element] = []
    private lazy var moved: [Move] = []
    private lazy var deleted: [Int] = []
    private lazy var reloaded: [Int: Element] = [:]
    private lazy var inserted: [Int: Element] = [:]
    private lazy var indexesToIgnore: [Int] = []
    
    // internal
    internal var count: Int { return current.count }
    internal private(set) lazy var current: [Element] = []
}

// MARK: - computed properties
public extension SourceDiff {
    var staged: [Element] {
        return apply(to: current)
    }
}

// MARK: - subscript
public extension SourceDiff {
    subscript(index: Int) -> Element {
        return current[index]
    }
    
    subscript(safe index: Int) -> Element? {
        return current[safe: index]
    }
    
    subscript(inStage index: Int) -> Element {
        return staged[index]
    }

    subscript(inStageSafe index: Int) -> Element? {
        return staged[safe: index]
    }
}

private extension SourceDiff {
    func apply(to: [Element]) -> [Element] {
        var elements = to
        
        // commit
        deleted.sorted(by: >).forEach { elements.remove(at: $0) }
        inserted.sorted { $0.key < $1.key }.forEach { elements.insert($0.value, at: $0.key) }
        elements.append(contentsOf: added)
        
        return elements
    }
    
    func cleanup() {
        deleted.removeAll()
        inserted.removeAll()
        added.removeAll()
        moved.removeAll()
        reloaded.removeAll()
        indexesToIgnore.removeAll()
    }
}

// MARK: - internal
internal extension SourceDiff {
    func reset() {
        current = apply(to: current)
        cleanup()
    }
    
    @discardableResult
    func commit() -> ChangeSet {
        let prev = current
        
        // commit
        deleted.sorted(by: >).forEach { current.remove(at: $0) }
        inserted.sorted { $0.key < $1.key }.forEach { current.insert($0.value, at: $0.key) }
        current.append(contentsOf: added)
        
        // inserted
        var indexes = inserted.map { $0.key }
        if !added.isEmpty {
            for index in (current.count - added.count)...(current.count - 1) {
                indexes.append(index)
            }
        }
        let realInserted = Set(indexes).subtracting(Set(indexesToIgnore))
        let insertedIndexSet = IndexSet(realInserted)
        
        // remapped
        let remapped = current.reduce([Int: Int]()) { dic, element in
            var dictionary = dic
            guard let newIndex = current.firstIndex(of: element) else { return dic }
            guard let oldIndex = prev.firstIndex(of: element) else { return dic }
            dictionary[newIndex] = oldIndex
            return dictionary
        }
        
        indexes = indexes.sorted(by: <)
        
        // deleted
        let realDeleted = Set(deleted).subtracting(Set(indexesToIgnore))
        let deletedIndexSet = IndexSet(realDeleted)
        
        // reloaded
        reloaded.sorted { $0.key < $1.key }.forEach { current[$0.key] = $0.value }
        let reloadedIndexSet = IndexSet(reloaded.keys)
        
        // moved
        let movedIndexes = moved
        
        // cleanup
        cleanup()
        
        return ChangeSet(inserted: insertedIndexSet,
                         deleted: deletedIndexSet,
                         reloaded: reloadedIndexSet,
                         remapped: remapped,
                         moved: movedIndexes)
    }
    
    func insert(element: Element, at index: Int, ignore: Bool = false) {
        inserted[index] = element
        if ignore {
            indexesToIgnore.append(index)
        }
    }
}

// MARK: - Add
public extension SourceDiff {
    func add(element: Element) {
        add(elements: [element])
    }
    
    func add(elements: [Element]) {
        added.append(contentsOf: elements)
    }
}

// MARK: - Insert
public extension SourceDiff {
    func insert(element: Element, at index: Int) {
        inserted[index] = element
    }
    
    func insert(elements: [Element], in range: ClosedRange<Int>) {
        precondition(elements.count == range.count)
        range.enumerated().forEach {
            let element = elements[$0.offset]
            let index = $0.element
            insert(element: element, at: index)
        }
    }
}

// MARK: - Delete
public extension SourceDiff {
    func delete(allOccurrencesOf element: Element) {
        delete(all: current.indexes(of: element))
    }
    
    @discardableResult
    func delete(at index: Int) -> Element {
        precondition(current.count > index)
        deleted.append(index)
        return current[index]
    }
    
    @discardableResult
    func delete(all indexes: Set<Int>) -> [Element] {
        precondition(indexes.isSubset(of: current.indices))
        return indexes.map(delete)
    }
    
    @discardableResult
    func delete(in range: ClosedRange<Int>) -> [Element] {
        precondition(Set(range).isSubset(of: current.indices))
        return range.map(delete)
    }
    
    @discardableResult
    func deleteAll() -> [Element] {
        return current.indices.map(delete)
    }
    
    @discardableResult
    func deleteAll(after startIndex: Int) -> [Element] {
        let indexes = current.indices.filter { $0 >= startIndex }
        return delete(all: Set(indexes))
    }
    
    @discardableResult
    func deleteAll(before endIndex: Int) -> [Element] {
        let indexes = current.indices.filter { $0 <= endIndex }
        return delete(all: Set(indexes))
    }
}

// MARK: - Move
public extension SourceDiff {
    func move(from fromIndex: Int, to toIndex: Int) {
        precondition(current.indices.contains(fromIndex))
        precondition(current.indices.contains(toIndex))
        
        let element = current[fromIndex]
        delete(at: fromIndex)
        insert(element: element, at: toIndex)
        indexesToIgnore.append(fromIndex)
        indexesToIgnore.append(toIndex)
        moved.append(Move(from: fromIndex, to: toIndex))
    }
    
    func move(from fromIndex: Int, to indexPath: IndexPath) {
        precondition(current.indices.contains(fromIndex))
        delete(at: fromIndex)
        indexesToIgnore.append(fromIndex)
        moved.append(Move(from: fromIndex, to: indexPath))
    }
}

// MARK: - Reload
public extension SourceDiff {
    func reload(at index: Int) {
        guard let element = current[safe: index] else { return }
        reloaded[index] = element
    }
    
    func reload(in range: ClosedRange<Int>) {
        range.forEach(reload)
    }
    
    func reload(element: Element) {
        let indexes = current.indexes(of: element)
        indexes.forEach { reloaded[$0] = element }
    }
    
    func reload(elements: [Element]) {
        elements.forEach(reload)
    }
}
