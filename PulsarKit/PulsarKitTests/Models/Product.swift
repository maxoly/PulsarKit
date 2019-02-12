//
//  Product.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 14/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

class Product: Hashable {
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Product: Bindable {
    func bind(to element: ProductCollectionViewCell) { }
}
