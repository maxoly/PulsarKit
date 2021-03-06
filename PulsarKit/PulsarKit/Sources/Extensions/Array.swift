//
//  Array.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 14/09/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func indexes(of element: Element) -> Set<Int> {
        Set(self.enumerated().filter { element == $0.element }.map { $0.offset })
    }
}

extension Array {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
