//
//  AutolayoutSize.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

public struct AutolayoutSize: Sizeable {
    public let verticalFittingPriority: UILayoutPriority
    public let horizontalFittingPriority: UILayoutPriority
    public let proposedContainerSize: CGSize?
    
    public init(horizontalFittingPriority: UILayoutPriority = .defaultHigh,
                verticalFittingPriority: UILayoutPriority = .fittingSizeLevel,
                proposedContainerSize: CGSize? = nil) {
        self.verticalFittingPriority = verticalFittingPriority
        self.horizontalFittingPriority = horizontalFittingPriority
        self.proposedContainerSize = proposedContainerSize
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView, at indexPath: IndexPath) -> CGSize {
        let containerSize = proposedContainerSize ?? adjustedSize(for: container, at: indexPath)
        let bounds = CGRect(origin: .zero, size: containerSize)
        
        // Frame
        view.frame = bounds
        view.bounds = bounds
        view.tag = .max
        
        // Bind model
        descriptor.bind(cell: view, with: model)
        
        // Layout
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
        
        // Run autolayout
        let viewSize = view.systemLayoutSizeFitting(containerSize,
                                                    withHorizontalFittingPriority: horizontalFittingPriority,
                                                    verticalFittingPriority: verticalFittingPriority)
        
        // Cache
        return viewSize
    }
}
