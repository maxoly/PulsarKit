//
//  DescriptorFactory.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 13/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public final class DescriptorFactory<Model: Hashable, Cell: UICollectionReusableView> {
    private let onFinish: (Descriptor) -> Void
    private let isStoryboard: Bool
    
    init(onFinish: @escaping (Descriptor) -> Void, isStoryboard: Bool = false) {
        self.onFinish = onFinish
        self.isStoryboard = isStoryboard
    }
}

public extension DescriptorFactory {
    @discardableResult
    func with<B: Binder>(binder: B) -> DescriptorConfiguration<Model, Cell> where B.Model == Model, B.Cell == Cell {
        let descriptor = CollectionDescriptor(binder: binder)
        descriptor.isCellAlreadyRegistered = isStoryboard
        onFinish(descriptor)
        return descriptor.configuration
    }
    
    @discardableResult
    func withoutBinder() -> DescriptorConfiguration<Model, Cell> {
        let binder = AnyBinder<Model, Cell>()
        let descriptor = CollectionDescriptor(binder: binder)
        descriptor.isCellAlreadyRegistered = isStoryboard
        onFinish(descriptor)
        return descriptor.configuration
    }
}

public extension DescriptorFactory where Model: Bindable, Model.Element == Cell {
    @discardableResult
    func withModelBinder() -> DescriptorConfiguration<Model, Cell> {
        let binder = ModelBinder<Model, Cell>()
        let descriptor = CollectionDescriptor(binder: binder)
        descriptor.isCellAlreadyRegistered = isStoryboard
        onFinish(descriptor)
        return descriptor.configuration
    }
}

public extension DescriptorFactory where Cell: Bindable, Cell.Element == Model {
    @discardableResult
    func withCellBinder() -> DescriptorConfiguration<Model, Cell> {
        let binder = CellBinder<Model, Cell>()
        let descriptor = CollectionDescriptor(binder: binder)
        descriptor.isCellAlreadyRegistered = isStoryboard
        onFinish(descriptor)
        return descriptor.configuration
    }
}
