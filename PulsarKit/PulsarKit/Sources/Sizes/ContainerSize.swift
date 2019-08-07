//
//  ContainerSize.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/03/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

public struct ContainerSize: Sizeable {
    let offset: UIOffset
    
    public init(offset: UIOffset = .zero) {
        self.offset = offset
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
        let sectionInset: UIEdgeInsets = container.sectionInset
        
        let collectionWidth = container.safeAreaLayoutGuide.layoutFrame.width
        let collectionHeight = container.safeAreaLayoutGuide.layoutFrame.height
        
        let width = collectionWidth - offset.horizontal - (sectionInset.left + sectionInset.right)
        let height = collectionHeight - offset.vertical - (sectionInset.top + sectionInset.bottom)
        
        return CGSize(width: width, height: height)
    }
}
