//
//  Binder.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol Binder {
    associatedtype Cell: UICollectionReusableView
    associatedtype Model: Hashable
    
    func bind(model: Model, to cell: Cell)
}
