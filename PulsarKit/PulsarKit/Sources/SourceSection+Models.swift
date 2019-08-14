//
//  SourceSection+Models.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 14/08/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

// MARK: - Add
public extension SourceSection {
    func add<Model: Hashable>(model: Model) {
        models.add(element: model)
    }
    
    func add<Model: Hashable>(models modelsToAdd: [Model]) {
        models.add(elements: modelsToAdd)
    }
}

// MARK: - Insert
public extension SourceSection {
    func insert<Model: Hashable>(model: Model, at index: Int) {
        models.insert(element: model, at: index)
    }
    
    func insert<Model: Hashable>(models modelsToInsert: [Model], in range: ClosedRange<Int>) {
        models.insert(elements: modelsToInsert, in: range)
    }
}

// MARK: - Delete
public extension SourceSection {
    func delete<Model: Hashable>(allInstancesIn modelsToDelete: [Model]) {
        models.delete(allInstancesIn: modelsToDelete)
    }
    
    func delete<Model: Hashable>(allInstancesOf model: Model) {
        models.delete(allInstancesOf: model)
    }
    
    func delete(at index: Int) {
        models.delete(at: index)
    }
    
    func delete(all indexes: Set<Int>) {
        models.delete(all: indexes)
    }
    
    func delete(in range: ClosedRange<Int>) {
        models.delete(in: range)
    }
    
    func deleteAll() {
        models.deleteAll()
    }
    
    func deleteAll(after startIndex: Int) {
        models.deleteAll(after: startIndex)
    }
    
    func deleteAll(before endIndex: Int) {
        models.deleteAll(before: endIndex)
    }
}

// MARK: - Move
public extension SourceSection {
    func move(from fromIndex: Int, to toIndex: Int) {
        models.move(from: fromIndex, to: toIndex)
    }
}

// MARK: - Reload
public extension SourceSection {
    func reload(at index: Int) {
        models.reload(at: index)
    }
    
    func reload(in range: ClosedRange<Int>) {
        models.reload(in: range)
    }
    
    func reload<Model: Hashable>(model: Model) {
        models.reload(element: model)
    }
    
    func reload<Model: Hashable>(models modelsToReload: [Model]) {
        models.reload(elements: modelsToReload)
    }
}
