//
//  ClosureBinder.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 21/05/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public struct ClosureBinder<M: Hashable, C: UICollectionReusableView>: Binder {
    public typealias Cell = C
    public typealias Model = M
    public let adapter: (M, C) -> Void
    
    public init(adapter: @escaping (M, C) -> Void) {
        self.adapter = adapter
    }
    
    public func bind(model: M, to cell: C) {
        adapter(model, cell)
    }
}
