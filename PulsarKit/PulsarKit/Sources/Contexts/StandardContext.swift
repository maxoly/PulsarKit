//
//  StandardContext.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

public final class StandardContext<Model: Hashable> {
    public let model: Model
    public let container: UICollectionView
    public let indexPath: IndexPath
    
    init(model: Model, container: UICollectionView, indexPath: IndexPath) {
        self.model = model
        self.container = container
        self.indexPath = indexPath
    }
}
