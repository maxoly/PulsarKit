//
//  MyCustomDescriptor.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

struct MyCustomDescriptor: Descriptor {    
    var handle: DescriptorDispatcher { self }
    
    var isCellAlreadyRegistered: Bool = false
    
    var modelType: Any.Type = User.self
    var cellType: Any.Type = User1CollectionViewCell.self
    var cellClass: AnyClass = User1CollectionViewCell.self
    var cellReuseIdentifier: String = "User1CollectionViewCell"
    
    func size(for model: Any, cell: UICollectionReusableView) -> Sizeable {
        TableSize()
    }
    
    func cellConfiguration() -> Any {
        Void()
    }
    
    func bind(cell: UIView, with model: Any) {
    }
    
    func create<C>() -> C? where C: UIView {
        UICollectionViewCell() as? C
    }
    
    func handle(model: AnyHashable, at indexPath: IndexPath) {
    }
}

extension MyCustomDescriptor: DescriptorDispatcher {
    func event<M>(_ event: Event.TargetMove, originalModel: M, container: UICollectionView, originalIndexPath: IndexPath, proposedIndexPath: IndexPath) -> IndexPath? where M: Hashable {
        nil
    }
    
    func event<M>(_ event: Event.Move, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool? where M: Hashable {
        nil
    }
    
    func event<M>(_ event: Event.Menu, model: M, container: UICollectionView, indexPath: IndexPath, selector: Selector?, sender: Any?) -> Bool? where M: Hashable {
        nil
    }
    
    func event<M>(_ event: Event.Should, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool? where M: Hashable {
        nil
    }
    
    func event<M, C>(_ event: Event.Display, model: M, container: UICollectionView, cell: C, indexPath: IndexPath) where M: Hashable {
    }
    
    func event<M>(_ event: Event.Selection, model: M, container: UICollectionView, indexPath: IndexPath) where M: Hashable {
    }
}
