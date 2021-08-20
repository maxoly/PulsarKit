//
//  DescriptorDispatcher.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 05/01/2021.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import Foundation

public protocol DescriptorDispatcher {
    func event<M: Hashable>(_ event: Event.Selection, model: M, container: UICollectionView, indexPath: IndexPath)
    func event<M: Hashable, C>(_ event: Event.Display, model: M, container: UICollectionView, cell: C, indexPath: IndexPath)
    func event<M: Hashable>(_ event: Event.Should, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool?
    func event<M: Hashable>(_ event: Event.Menu, model: M, container: UICollectionView, indexPath: IndexPath, selector: Selector?, sender: Any?) -> Bool?
    func event<M: Hashable>(_ event: Event.Move, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool?
    func event<M: Hashable>(_ event: Event.TargetMove, originalModel: M, container: UICollectionView, originalIndexPath: IndexPath, proposedIndexPath: IndexPath) -> IndexPath?
}

public extension DescriptorDispatcher {
    func event<M: Hashable>(_ event: Event.Menu, model: M, container: UICollectionView, indexPath: IndexPath) -> Bool? {
        true
    }
}
