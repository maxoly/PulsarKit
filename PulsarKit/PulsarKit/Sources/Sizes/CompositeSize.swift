//
//  CompositeSize.swift
//  RIBConnectUIKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2018 DuckMa Srl. All rights reserved.
//

import UIKit

public struct CompositeSize: Sizeable {
    let widthSize: Sizeable
    let heightSize: Sizeable
    
    public init(widthSize: Sizeable, heightSize: Sizeable) {
        self.widthSize = widthSize
        self.heightSize = heightSize
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
        let width = widthSize.size(for: view, descriptor: descriptor, model: model, in: container).width
        let height = heightSize.size(for: view, descriptor: descriptor, model: model, in: container).height
        return CGSize(width: width, height: height)
    }
}
