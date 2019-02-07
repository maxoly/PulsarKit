//
//  DescriptorBuilder.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation

public struct DescriptorBuilder<Model: Hashable> {
    private let onFinish: (Descriptor) -> Void
    
    init(onFinish: @escaping (Descriptor) -> Void) {
        self.onFinish = onFinish
    }
    
    public func use<Cell: UIView>(_ type: Cell.Type) -> DescriptorFactory<Model, Cell> {
        return DescriptorFactory<Model, Cell>(onFinish: onFinish)
    }
    
    public func useStoryboard<Cell: UIView>(_ type: Cell.Type) -> DescriptorFactory<Model, Cell> {
        return DescriptorFactory<Model, Cell>(onFinish: onFinish, isStoryboard: true)
    }
}
