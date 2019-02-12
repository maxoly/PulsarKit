//
//  SegmentedSize.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 21/03/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public struct SegmentedSize: Sizeable {
    private let numOfSegmentForWidth: CGFloat?
    private let numOfSegmentForHeight: CGFloat?
    
    public init(numOfSegmentForWidth: CGFloat? = nil, numOfSegmentForHeight: CGFloat? = nil) {
        self.numOfSegmentForWidth = numOfSegmentForWidth
        self.numOfSegmentForHeight = numOfSegmentForHeight
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
        var height: CGFloat = 0.0
        var width: CGFloat = 0.0
        
        if let segments = numOfSegmentForWidth {
            width = container.frame.width / segments
        } else {
            width = AutolayoutSize().size(for: view, descriptor: descriptor, model: model, in: container).width
        }
        
        if let segments = numOfSegmentForHeight {
            height = container.frame.height / segments
        } else {
            height = AutolayoutSize().size(for: view, descriptor: descriptor, model: model, in: container).height
        }
        
        return CGSize(width: width, height: height)
    }
}
