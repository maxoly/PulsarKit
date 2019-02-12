//
//  AnyBinder.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public struct AnyBinder<M: Hashable, C: UICollectionReusableView>: Binder {
    public func bind(model: M, to cell: C) {}
}
