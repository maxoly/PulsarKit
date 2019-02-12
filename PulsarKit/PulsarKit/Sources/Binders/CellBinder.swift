//
//  ConfigurationBinder.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public struct CellBinder<M, C: UICollectionReusableView & Bindable>: Binder where C.Element == M {
    public typealias Cell = C
    public typealias Model = M
    
    public init() {}
    
    public func bind(model: M, to cell: C) {
        cell.bind(to: model)
    }
}
