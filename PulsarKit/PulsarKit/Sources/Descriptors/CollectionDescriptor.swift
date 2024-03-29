//
//  AnyDescriptor.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 13/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

open class CollectionDescriptor<Model, Cell, B: Binder>: Descriptor where B.Model == Model, B.Cell == Cell {
    private let binder: B
    
    public var modelType: Any.Type { Model.self }
    public var cellType: Any.Type { Cell.self }
    public var cellClass: AnyClass { Cell.self }
    public var cellReuseIdentifier: String { String(describing: Cell.self) }
    public var isCellAlreadyRegistered: Bool = false
    public var handle: DescriptorDispatcher { self }
    
    public let configuration = DescriptorConfiguration<Model, Cell>()
    
    public init(binder: B) {
        self.binder = binder
    }
    
    public func cellConfiguration() -> Any {
        configuration
    }
    
    public func size(for model: Any, cell: UICollectionReusableView) -> Sizeable {
        if let currentModel = model as? Model, let modelSize = configuration.sizes[currentModel] {
            return modelSize
        }
        
        if let sizeable = configuration.size {
            return sizeable
        }
        
        if let sizeable = cell as? Sizeable {
            return sizeable
        }
        
        if let sizeable = model as? Sizeable {
            return sizeable
        }
        
        return TableSize()
    }
    
    public func create<C: UIView>() -> C? {
        let bundle = Bundle(for: cellClass)
        let nibName = String(describing: cellClass)
        let nibUrl = bundle.path(forResource: nibName, ofType: "nib")
        
        if nibUrl != nil {
            return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: nil, options: nil).first as? C
        } else {
            return Cell() as? C
        }
    }
    
    public func bind(cell: UIView, with model: Any) {
        guard let cell = cell as? Cell else { return }
        guard let model = model as? Model else { return }
        binder.bind(model: model, to: cell)
    }
}

extension CollectionDescriptor: DescriptorDispatcher {
    public func event<M: Hashable>(_ event: Event.Selection, model: M, container: UICollectionView, indexPath: IndexPath) {
        guard let model = model as? Model else { return }
        
        let context = StandardContext(model: model, container: container, indexPath: indexPath)
        configuration.handlers[model]?.dispatch(event: event, context: context)
        configuration.on.dispatch(event: event, context: context)
    }
    
    public func event<M: Hashable>(_ event: Event.Should, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool? {
        guard let model = model as? Model else { return true }
        
        let context = StandardContext(model: model, container: container, indexPath: indexPath)
        let modelResult = configuration.handlers[model]?.dispatch(event: event, context: context)
        return modelResult ?? configuration.on.dispatch(event: event, context: context)
    }
    
    public func event<M: Hashable, C>(_ event: Event.Display, model: M, container: UICollectionView, cell: C, indexPath: IndexPath) {
        guard let model = model as? Model else { return }
        guard let cell = cell as? Cell else { return }
        
        let context = CellContext(model: model, cell: cell, container: container, indexPath: indexPath)
        configuration.handlers[model]?.dispatch(event: event, context: context)
        configuration.on.dispatch(event: event, context: context)
    }
    
    public func event<M: Hashable>(_ event: Event.Menu, model: M, container: UICollectionView, indexPath: IndexPath, selector: Selector?, sender: Any?) -> Bool? {
        guard let model = model as? Model else { return nil }
        
        let context = ActionContext(model: model, container: container, indexPath: indexPath, action: nil, sender: nil)
        let modelResult = configuration.handlers[model]?.dispatch(event: event, context: context)
        return modelResult ?? configuration.on.dispatch(event: event, context: context)
    }
    
    public func event<M: Hashable>(_ event: Event.Move, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool? {
        guard let model = model as? Model else { return true }
        
        let context = StandardContext(model: model, container: container, indexPath: indexPath)
        let modelResult = configuration.handlers[model]?.dispatch(event: event, context: context)
        return modelResult ?? configuration.on.dispatch(event: event, context: context)
    }
    
    public func event<M: Hashable>(_ event: Event.TargetMove, originalModel: M, container: UICollectionView, originalIndexPath: IndexPath, proposedIndexPath: IndexPath) -> IndexPath? {
        guard let model = originalModel as? Model else { return nil }
        
        let context = TargetMoveContext(originalModel: model, container: container, originalIndexPath: originalIndexPath, proposedIndexPath: proposedIndexPath)
        let modelResult = configuration.handlers[model]?.dispatch(event: event, context: context)
        return modelResult ?? configuration.on.dispatch(event: event, context: context)
    }
}
