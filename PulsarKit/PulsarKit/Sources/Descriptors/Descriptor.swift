//
//  Descriptor.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol Descriptor {
    // properties
    var modelType: Any.Type { get }
    var cellType: Any.Type { get }
    var cellClass: AnyClass { get }
    var cellReuseIdentifier: String { get }
    var isCellAlreadyRegistered: Bool { get }
    var handle: DescriptorDispatcher { get }
    
    // methods
    func cellConfiguration() -> Any
    func size(for model: Any, cell: UICollectionReusableView) -> Sizeable
    func create<C: UIView>() -> C?
    func bind(cell: UIView, with model: Any)
}

public protocol DescriptorDispatcher {
    func event<M: Hashable>(_ event: Event.Selection, model: M, container: UICollectionView, indexPath: IndexPath)
    func event<M: Hashable, C>(_ event: Event.Display, model: M, container: UICollectionView, cell: C, indexPath: IndexPath)
    func event<M: Hashable>(_ event: Event.Should, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool?
    func event<M: Hashable>(_ event: Event.Menu, model: M, container: UICollectionView, indexPath: IndexPath, selector: Selector?, sender: Any?) -> Bool?
}

public extension DescriptorDispatcher {
    func event<M: Hashable>(_ event: Event.Menu, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool? {
        return true
    }
}
