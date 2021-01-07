//
//  Descriptor.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol Descriptor {
    // Properties
    var modelType: Any.Type { get }
    var cellType: Any.Type { get }
    var cellClass: AnyClass { get }
    var cellReuseIdentifier: String { get }
    var isCellAlreadyRegistered: Bool { get }
    var handle: DescriptorDispatcher { get }
    
    // Methods
    func cellConfiguration() -> Any
    func size(for model: Any, cell: UICollectionReusableView) -> Sizeable
    func create<C: UIView>() -> C?
    func bind(cell: UIView, with model: Any)
}
