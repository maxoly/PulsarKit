//
//  TargetMoveContext.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 20/08/21.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import Foundation

public final class TargetMoveContext<Model: Hashable> {
    public let originalModel: Model
    public let container: UICollectionView
    public let originalIndexPath: IndexPath
    public let proposedIndexPath: IndexPath

    init(originalModel: Model,
         container: UICollectionView,
         originalIndexPath: IndexPath,
         proposedIndexPath: IndexPath) {
        self.originalModel = originalModel
        self.container = container
        self.originalIndexPath = originalIndexPath
        self.proposedIndexPath = proposedIndexPath
    }
}
