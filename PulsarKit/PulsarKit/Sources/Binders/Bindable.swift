//
//  Bindable.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol Bindable {
    associatedtype Element: Hashable
    func bind(to element: Element)
}
