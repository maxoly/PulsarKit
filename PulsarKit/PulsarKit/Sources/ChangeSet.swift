//
//  ChangeSet.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 13/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation

internal struct ChangeSet {
    let inserted: IndexSet
    let deleted: IndexSet
    let reloaded: IndexSet
    let remapped: [Int: Int]
    let moved: [Move]
}

internal struct Move {
    let from: Int
    let to: Int
    let toSection: Int?
    
    init(from: Int, to: Int) {
        self.from = from
        self.to = to
        self.toSection = nil
    }
    
    init(from: Int, to indexPath: IndexPath) {
        self.from = from
        self.to = indexPath.item
        self.toSection = indexPath.section
    }
}
