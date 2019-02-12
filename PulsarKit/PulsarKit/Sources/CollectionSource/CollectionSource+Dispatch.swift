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
        on.dispatch(event: event, context: StandardContext(model: model, container: container, indexPath: indexPath))
    }
    
    func dispatch(event: Event.Should, container: UICollectionView, indexPath: IndexPath) -> Bool {
        let model = self.model(at: indexPath)
        let result = descriptor(for: model)?.handle.event(event, model: model, container: container, indexPath: indexPath)
        return result ?? on.dispatch(event: event, context: StandardContext(model: model, container: container, indexPath: indexPath)) ?? true
    }
    
    func dispatch(event: Event.Display, container: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        guard let model = self.model(safeAt: indexPath) else { return }
        descriptor(for: model)?.handle.event(event, model: model, container: container, cell: cell, indexPath: indexPath)
        let context = CellContext(model: model, cell: cell, container: container, indexPath: indexPath)
        on.dispatch(event: event, context: context)
    }
    
    func dispatch(event: Event.Menu, container: UICollectionView, indexPath: IndexPath) -> Bool {
        let model = self.model(at: indexPath)
        let result = descriptor(for: model)?.handle.event(event, model: model, container: container, indexPath: indexPath)
        let context = ActionContext(model: model, container: container, indexPath: indexPath, action: nil, sender: nil)
        return result ?? on.dispatch(event: event, context: context) ?? false
    }
    
    func dispatch(event: Event.Menu, container: UICollectionView, indexPath: IndexPath, action: Selector, sender: Any?) -> Bool {
        let model = self.model(at: indexPath)
        let result = descriptor(for: model)?.handle.event(event, model: model, container: container, indexPath: indexPath)
        let context = ActionContext(model: model, container: container, indexPath: indexPath, action: action, sender: sender)
        return result ?? on.dispatch(event: event, context: context) ?? false
    }
}
