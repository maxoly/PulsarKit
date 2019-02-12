//
//  DescriptorConfiguration.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 22/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public final class DescriptorConfiguration<Model: Hashable, Cell: UICollectionReusableView> {
    internal var size: Sizeable = TableSize()
    internal lazy var sizes = [Model: Sizeable]()
    internal lazy var handlers = [Model: CollectionEvents<Model, Cell>]()
    public private(set) lazy var on = CollectionEvents<Model, Cell>()
    
    @discardableResult
    public func set(sizeable: Sizeable) -> Self {
        size = sizeable
        return self
    }
    
    @discardableResult
    public func set(sizeable: Sizeable, for model: Model) -> Self {
        sizes[model] = sizeable
        return self
    }
    
    @discardableResult
    public func on(model: Model) -> CollectionEvents<Model, Cell> {
        guard let events = handlers[model] else {
            let result = CollectionEvents<Model, Cell>()
            handlers[model] = result
            return result
        }
        
        return events
    }
}
