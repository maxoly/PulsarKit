//
//  FixedSize.swift
//  RIBConnectUIKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2018 DuckMa Srl. All rights reserved.
//

import UIKit

public struct FixedSize: Sizeable {
    let width: CGFloat
    let height: CGFloat
    
    public init(width: CGFloat = 0, height: CGFloat = 0) {
        self.width = width
        self.height = height
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
        return CGSize(width: width, height: height)
    }
}
