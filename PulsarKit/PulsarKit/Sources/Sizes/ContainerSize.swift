//
//  ContainerSize.swift
//  RIBConnectUIKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2018 DuckMa Srl. All rights reserved.
//

import UIKit

public struct ContainerSize: Sizeable {
    let offset: UIOffset
    
    public init(offset: UIOffset = .zero) {
        self.offset = offset
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
        let sectionInset: UIEdgeInsets = container.sectionInset
        let width = container.bounds.width - offset.horizontal - (sectionInset.left + sectionInset.right)
        let height = container.bounds.height - offset.vertical
        
        return CGSize(width: width, height: height)
    }
}
