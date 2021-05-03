//
//  CompositeSize.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

public struct CompositeSize: Sizeable {
    let widthSize: Sizeable
    let heightSize: Sizeable
    
    public init(widthSize: Sizeable = AutolayoutSize(), heightSize: Sizeable = AutolayoutSize()) {
        self.widthSize = widthSize
        self.heightSize = heightSize
    }
        
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView, at indexPath: IndexPath) -> CGSize {
        let width = widthSize.size(for: view, descriptor: descriptor, model: model, in: container, at: indexPath).width
        let height = heightSize.size(for: view, descriptor: descriptor, model: model, in: container, at: indexPath).height
        return CGSize(width: width, height: height)
    }
}
