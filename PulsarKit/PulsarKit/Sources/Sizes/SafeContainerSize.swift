//
//  SafeContainerSize.swift
//  RIBConnectUIKit
//
//  Created by Massimo Oliviero on 08/03/2018.
//  Copyright © 2018 DuckMa Srl. All rights reserved.
//

import Foundation

public struct SafeContainerSize: Sizeable {
    public init() {}
    public func size<View: UIView>(forView view: View, descriptor: Descriptable, model: AnyHashable, in container: UICollectionView) -> CGSize {
        
        let x: CGFloat
        if #available(iOS 11.0, *) {
            x = container.safeAreaInsets.left + container.safeAreaInsets.right
        } else {
            x = 0
        }
        
        let y: CGFloat
        if #available(iOS 11.0, *) {
            y = container.safeAreaInsets.top + container.safeAreaInsets.bottom
        } else {
            y = 0
        }
        
        return container.bounds.insetBy(dx: x, dy: y).size
    }
}
