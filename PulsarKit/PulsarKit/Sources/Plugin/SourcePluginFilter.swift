//
//  SourcePluginFilter.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol SourcePluginFilter {
    func filter<Model: Hashable>(source: CollectionSource, model: Model) -> Model
    func filter<Cell: UICollectionReusableView>(source: CollectionSource, cell: Cell, at indexPath: IndexPath) -> Cell
}

public extension SourcePluginFilter {
    func filter<Model: Hashable>(source: CollectionSource, model: Model) -> Model { return model }
    func filter<Cell: UICollectionReusableView>(source: CollectionSource, cell: Cell, at indexPath: IndexPath) -> Cell { return cell }
}
