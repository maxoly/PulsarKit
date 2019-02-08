//
//  CollectionSource+Models.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 07/09/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation

// MARK: - Add
public extension CollectionSource {
    func add<Model: Hashable>(model: Model) {
        lastSection.models.add(element: model)
    }
    
    func add<Model: Hashable>(elements: [Model]) {
        lastSection.models.add(elements: elements)
    }
}

// MARK: - Insert
public extension CollectionSource {
    func insert<Model: Hashable>(model: Model, at index: Int) {
        lastSection.models.insert(element: model, at: index)
    }
    
    func insert<Model: Hashable>(elements: [Model], in range: ClosedRange<Int>) {
        lastSection.models.insert(elements: elements, in: range)
    }
}

// MARK: - Delete
public extension CollectionSource {
    func delete<Model: Hashable>(allInstancesIn models: [Model]) {
        lastSection.models.delete(allInstancesIn: models)
    }
    
    func delete<Model: Hashable>(allInstancesOf model: Model) {
        lastSection.models.delete(allInstancesOf: model)
    }
    
    func delete(at index: Int) {
        lastSection.models.delete(at: index)
    }
    
    func delete(all indexes: Set<Int>) {
        lastSection.models.delete(all: indexes)
    }
    
    func delete(in range: ClosedRange<Int>) {
        lastSection.models.delete(in: range)
    }
    
    func deleteAll() {
        lastSection.models.deleteAll()
    }
    
    func deleteAll(after startIndex: Int) {
        lastSection.models.deleteAll(after: startIndex)
    }
    
    func deleteAll(before endIndex: Int) {
        lastSection.models.deleteAll(before: endIndex)
    }
}

// MARK: - Move
public extension CollectionSource {
    func move(from fromIndex: Int, to toIndex: Int) {
        lastSection.models.move(from: fromIndex, to: toIndex)
    }
    
    func move(from fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        precondition(sections.count > toIndexPath.section, "Invalid destination section index")
        precondition(sections.count > fromIndexPath.section, "Invalid origin section index")
        
        let element = sections[fromIndexPath.section].models[fromIndexPath.item]
        sections[fromIndexPath.section].models.move(from: fromIndexPath.item, to: toIndexPath)
        sections[toIndexPath.section].models.insert(element: element, at: toIndexPath.item, ignore: true)
    }
}

// MARK: - Reload
public extension CollectionSource {
    func reload(at index: Int) {
        lastSection.models.reload(at: index)
    }
    
    func reload(in range: ClosedRange<Int>) {
        lastSection.models.reload(in: range)
    }
    
    func reload<Model: Hashable>(model: Model) {
        lastSection.models.reload(element: model)
    }
    
    func reload<Model: Hashable>(models: [Model]) {
        lastSection.models.reload(elements: models)
    }
    
    func reload<Model: Hashable>(allInstancesOf model: Model) {
        reload(allIntancesIn: [model])
    }
        
    func reload<Model: Hashable>(allIntancesIn models: [Model]) {
        sections.current.forEach { $0.models.reload(elements: models) }
    }
}
