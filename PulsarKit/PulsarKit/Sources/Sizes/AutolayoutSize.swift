//
//  AutolayoutSize.swift
//  RIBConnectUIKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2018 DuckMa Srl. All rights reserved.
//

import UIKit

public struct AutolayoutSize: Sizeable {    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
        // starting bounds
        var bounds = container.bounds
        bounds = bounds.inset(by: container.contentInset)
        bounds = bounds.inset(by: container.sectionInset)
        
        // frame
        view.frame = bounds
        view.bounds = bounds
        
        // bind model
        descriptor.bind(cell: view, with: model)
        
        // layout
        view.setNeedsUpdateConstraints()
        view.layoutIfNeeded()
        
        // run autolayout
        let viewSize = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        // cache
        return viewSize
    }
}
