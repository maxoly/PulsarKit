//
//  ActionContext.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/10/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public final class ActionContext<Model: Hashable> {
    public let model: Model
    public let container: UICollectionView
    public let indexPath: IndexPath
    public let action: Selector?
    public let sender: Any?
    
    init(model: Model, container: UICollectionView, indexPath: IndexPath, action: Selector?, sender: Any?) {
        self.model = model
        self.container = container
        self.indexPath = indexPath
        self.action = action
        self.sender = sender
    }
}

extension ActionContext {
    var standard: StandardContext<Model> {
        StandardContext(model: model, container: container, indexPath: indexPath)
    }
}
