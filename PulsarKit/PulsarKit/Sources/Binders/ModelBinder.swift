//
//  ModelBinder.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public struct ModelBinder<M: Hashable & Bindable, C: UICollectionReusableView>: Binder where M.Element == C {
    public typealias Cell = C
    public typealias Model = M
    
    public init() {}
    
    public func bind(model: M, to cell: C) {
        model.bind(to: cell)
    }
}
