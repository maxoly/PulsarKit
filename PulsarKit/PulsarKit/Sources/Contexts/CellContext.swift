//
//  CellContext.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/10/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public final class CellContext<Model: Hashable, Cell: UICollectionReusableView> {
    public let model: Model
    public let cell: Cell
    public let container: UICollectionView
    public let indexPath: IndexPath
    
    init(model: Model, cell: Cell, container: UICollectionView, indexPath: IndexPath) {
        self.model = model
        self.cell = cell
        self.container = container
        self.indexPath = indexPath
    }
}
