//
//  ContainerSize.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

public struct ContainerSize: Sizeable {
    let offset: UIEdgeInsets
    
    public init(offset: UIEdgeInsets = .zero) {
        self.offset = offset
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView, at indexPath: IndexPath) -> CGSize {
        adjustedSize(for: container, at: indexPath, offset: offset)
    }
}
