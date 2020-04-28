//
//  Source.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol Source: AnyObject {
    var sections: SourceDiff<SourceSection> { get }
    var plugins: [SourcePlugin] { get }
    var firstSection: SourceSection { get }
    var lastSection: SourceSection { get }
    
    func add(plugin: SourcePlugin)
    func update(forceReload: Bool, completion: ((Bool) -> Void)?)
}

// MARK: - Section
public extension Source {
    var firstSection: SourceSection {
        guard let section = sections.staged.first else {
            return sections.add()
        }
        
        return section
    }
    
    var lastSection: SourceSection {
        guard let section = sections.staged.last else {
            return sections.add()
        }
        
        return section
    }
}

// MARK: - Update
public extension Source {
    func update() {
        update(forceReload: false, completion: nil)
    }
    
    func update(forceReload: Bool) {
        update(forceReload: forceReload, completion: nil)
    }
}

// MARK: - Model
public extension Source {
    var models: [AnyHashable] {
        let result = sections.current.map { $0.models.current }
        let models = result.flatMap { $0 }
        return models
    }
    
    var modelsInStage: [AnyHashable] {
        let result = sections.staged.map { $0.models.staged }
        let models = result.flatMap { $0 }
        return models
    }
    
    func model(at indexPath: IndexPath) -> AnyHashable {
        let section = sections[indexPath.section]
        let model = section.models[indexPath.item]
        return model
    }
    
    func model(safeAt indexPath: IndexPath) -> AnyHashable? {
        guard let section = sections[safe: indexPath.section] else { return nil }
        guard let model = section.models[safe: indexPath.item] else { return nil }
        return model
    }
    
    func model(inStageAt indexPath: IndexPath) -> AnyHashable {
        let section = sections[inStage: indexPath.section]
        let model = section.models[inStage: indexPath.item]
        return model
    }
    
    func indexPaths(of model: AnyHashable) -> [IndexPath] {
        sections.current
            .enumerated()
            .map { (section: $0.offset, elements: $0.element.models.current.enumerated()) }
            .flatMap { val in val.elements
                .filter { $0.element == model }
                .map { (section: val.section, item: $0.offset, model: $0.element) }
            }
            .map { IndexPath(item: $0.item, section: $0.section) }
    }
}
