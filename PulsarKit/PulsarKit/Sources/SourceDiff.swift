//
//  SourceDiff.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public final class SourceDiff<Element: Hashable> {
    // Private
    private lazy var added: [Element] = []
    private lazy var moved: [Move] = []
    private lazy var deleted: Set<Int> = []
    private lazy var reloaded: [Int: Element] = [:]
    private lazy var inserted: [Int: Element] = [:]
    private lazy var indexesToIgnore: [Int] = []
    private lazy var elementsToReload: Set<Element> = []
    
    // Internal
    internal var count: Int { current.count }
    internal private(set) lazy var current: [Element] = []
}

// MARK: - computed properties
public extension SourceDiff {
    var staged: [Element] {
        apply(to: current)
    }
    
    func currentOf<T>(type: T.Type) -> [T] {
        current.map { $0 as? T }.compactMap { $0 }
    }
    
    func stagedOf<T>(type: T.Type) -> [T] {
        staged.map { $0 as? T }.compactMap { $0 }
    }
}

// MARK: - subscript
public extension SourceDiff {
    subscript(index: Int) -> Element {
        current[index]
    }
    
    subscript(safe index: Int) -> Element? {
        current[safe: index]
    }
    
    subscript(inStage index: Int) -> Element {
        staged[index]
    }

    subscript(inStageSafe index: Int) -> Element? {
        staged[safe: index]
    }
}

public extension SourceDiff {
    func forEach(_ body: (Element) throws -> Void) rethrows {
        try current.forEach(body)
    }
}

private extension SourceDiff {
    func apply(to: [Element]) -> [Element] {
        var elements = to
        
        // Commit
        reloaded.sorted { $0.key < $1.key }.forEach { elements[$0.key] = $0.value }
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
    
    func commitReloaded() -> IndexSet {
        // Reloaded
        let findexes = elementsToReload.map { current.indexes(of: $0) }.flatMap { $0 }
        let reloadedIndexSet = IndexSet(findexes)
        elementsToReload.removeAll()
        return reloadedIndexSet
    }
    
    @discardableResult
    func commit() -> ChangeSet {
        let prev = current
        
        // Reloaded
        reloaded.sorted { $0.key < $1.key }.forEach { current[$0.key] = $0.value }
        let reloadedIndexSet = IndexSet(reloaded.keys)
        
        // Commit
        deleted.sorted(by: >).forEach { current.remove(at: $0) }
        inserted.sorted { $0.key < $1.key }.forEach { current.insert($0.value, at: $0.key) }
        current.append(contentsOf: added)
        
        // Inserted
        var indexes = inserted.map { $0.key }
        if !added.isEmpty {
            for index in (current.count - added.count)...(current.count - 1) {
                indexes.append(index)
            }
        }
        let realInserted = Set(indexes).subtracting(Set(indexesToIgnore))
        let insertedIndexSet = IndexSet(realInserted)
        
        // Remapped
        let remapped = current.reduce(into: [Int: Int]()) { dictionary, element in
            guard let newIndex = current.firstIndex(of: element) else { return }
            guard let oldIndex = prev.firstIndex(of: element) else { return }
            dictionary[newIndex] = oldIndex
        }
        
        indexes = indexes.sorted(by: <)
        
        // Deleted
        let realDeleted = Set(deleted).subtracting(Set(indexesToIgnore))
        let deletedIndexSet = IndexSet(realDeleted)
        
        // Moved
        let movedIndexes = moved
        
        // Cleanup
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
    @discardableResult
    func add(element: Element) -> Element {
        add(elements: [element])
        return element
    }
    
    func add(elements: [Element]) {
        added.append(contentsOf: elements)
    }
}

// MARK: - Insert
public extension SourceDiff {
    @discardableResult
    func insert(element: Element, at index: Int) -> Element {
        inserted[index] = element
        return element
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
    func delete(allInstancesOf element: Element) {
        delete(all: current.indexes(of: element))
    }
    
    func delete(allInstancesIn elements: [Element]) {
        let indexes = elements.map(current.indexes).reduce(into: Set<Int>()) { $0.formUnion($1) }
        delete(all: indexes)
    }
    
    @discardableResult
    func delete(at index: Int) -> Element {
        precondition(current.count > index)
        deleted.insert(index)
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
        current.indices.map(delete)
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
    var hasReloaded: Bool {
        elementsToReload.isEmpty == false
    }
    
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
        
        // Merge Reload
        elementsToReload.insert(element)
    }
    
    func reload(elements: [Element]) {
        elements.forEach(reload)
    }
}

public extension SourceDiff where Element: Equatable {
    func merge(elements: [Element]) {
        // Elements to remove
        let toDelete = staged.filter { elements.contains($0) == false }
        delete(allInstancesIn: toDelete)
        
        // Elements to add
        let toAdd = elements.filter { staged.contains($0) == false }
        for element in toAdd {
            let newIndex = elements.indexes(of: element)
            insert(element: element, at: newIndex.first ?? 0)
        }
        
        // Elements to reload
        let toReload = elements.filter { current.contains($0) }
        reload(elements: toReload)
    }
}
