//
//  CollectionSource+Dispatch.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/10/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

extension CollectionSource {
    func dispatch(event: Event.Selection, container: UICollectionView, indexPath: IndexPath) {
        let model = self.model(at: indexPath)
        descriptor(for: model)?.handle.event(event, model: model, container: container, indexPath: indexPath)
        let context = StandardContext(model: model, container: container, indexPath: indexPath)
        on.dispatch(event: event, context: context)
        events.forEach { $0.dispatch(source: self, event: event, context: context) }
    }
    
    func dispatch(event: Event.Should, container: UICollectionView, indexPath: IndexPath) -> Bool {
        let model = self.model(at: indexPath)
        let context = StandardContext(model: model, container: container, indexPath: indexPath)
        let standard = true
        
        let specific = descriptor(for: model)?.handle.event(event, model: model, container: container, indexPath: indexPath) ?? standard
        let general = on.dispatch(event: event, context: context) ?? standard
        let plugin = events.reduce(standard) { $0 && ($1.dispatch(source: self, event: event, context: context) ?? standard) }
        
        return specific && general && plugin
    }
    
    func dispatch(event: Event.Display, container: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        guard let model = self.model(safeAt: indexPath) else { return }
        descriptor(for: model)?.handle.event(event, model: model, container: container, cell: cell, indexPath: indexPath)
        let context = CellContext(model: model, cell: cell, container: container, indexPath: indexPath)
        on.dispatch(event: event, context: context)
        events.forEach { $0.dispatch(source: self, event: event, context: context) }
    }
    
    func dispatch(event: Event.Menu, container: UICollectionView, indexPath: IndexPath) -> Bool {
        let model = self.model(at: indexPath)
        let context = ActionContext(model: model, container: container, indexPath: indexPath, action: nil, sender: nil)
        let standard = false
        
        let specific = descriptor(for: model)?.handle.event(event, model: model, container: container, indexPath: indexPath) ?? standard
        let general = on.dispatch(event: event, context: context) ?? standard
        let plugin = events.reduce(standard) { $0 && ($1.dispatch(source: self, event: event, context: context) ?? standard) }
        
        return specific && general && plugin
    }
    
    func dispatch(event: Event.Menu, container: UICollectionView, indexPath: IndexPath, action: Selector, sender: Any?) -> Bool {
        let model = self.model(at: indexPath)
        let context = ActionContext(model: model, container: container, indexPath: indexPath, action: action, sender: sender)
        let standard = false
        
        let specific = descriptor(for: model)?.handle.event(event, model: model, container: container, indexPath: indexPath) ?? standard
        let general = on.dispatch(event: event, context: context) ?? standard
        let plugin = events.reduce(standard) { $0 && ($1.dispatch(source: self, event: event, context: context) ?? standard) }
        
        return specific && general && plugin
    }
}
