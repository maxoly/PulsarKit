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
    
    public init(horizontalFittingPriority: UILayoutPriority = .defaultHigh, verticalFittingPriority: UILayoutPriority = .fittingSizeLevel) {
        self.verticalFittingPriority = verticalFittingPriority
        self.horizontalFittingPriority = horizontalFittingPriority
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
        // Starting bounds
        var bounds = container.bounds
        bounds = bounds.inset(by: container.contentInset)
        bounds = bounds.inset(by: container.sectionInset)
        
        // Frame
        view.frame = bounds
        view.bounds = bounds
        
        // Bind model
        descriptor.bind(cell: view, with: model)
        
        // Layout
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
        
        // Run autolayout
        let viewSize = view.systemLayoutSizeFitting(bounds.size,
                                                    withHorizontalFittingPriority: horizontalFittingPriority,
                                                    verticalFittingPriority: verticalFittingPriority)
        
        // Cache
        return viewSize
    }
}
