//
//  SegmentedSize.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 21/03/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public struct SplittedSize {
    public let numOfElementsInWidth: CGFloat?
    public let numOfElementsInHeight: CGFloat?
    
    public let widthSize: Sizeable?
    public let heightSize: Sizeable?
    
    public init(numOfElementsInWidth: CGFloat, numOfElementsInHeight: CGFloat) {
        self.numOfElementsInWidth = numOfElementsInWidth
        self.numOfElementsInHeight = numOfElementsInHeight
        self.widthSize = nil
        self.heightSize = nil
    }
    
    public init(numOfElementsInWidth: CGFloat, heightSize: Sizeable? = nil) {
        self.numOfElementsInWidth = numOfElementsInWidth
        self.numOfElementsInHeight = nil
        self.widthSize = nil
        self.heightSize = heightSize
    }
    
    public init(numOfElementsInHeight: CGFloat, widthSize: Sizeable? = nil) {
        self.numOfElementsInWidth = nil
        self.numOfElementsInHeight = numOfElementsInHeight
        self.widthSize = widthSize
        self.heightSize = nil
    }
}

// MARK: - Sizeable
extension SplittedSize: Sizeable {
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView, at indexPath: IndexPath) -> CGSize {
        let direction = scrollDirection(in: container)
        let containerSize = adjustedSize(for: container, at: indexPath)
        
        switch direction {
        case .vertical:
            let width = widthSize(for: view,
                                  descriptor: descriptor,
                                  model: model,
                                  in: container,
                                  at: indexPath,
                                  alternativeSize: alternativeSize(for: .width))
            
            let height = heightSize(for: view,
                                    descriptor: descriptor,
                                    model: model,
                                    in: container,
                                    at: indexPath,
                                    alternativeSize: alternativeSize(for: .height, with: CGSize(width: width, height: containerSize.height)))
            
            return CGSize(width: width, height: height)

        case .horizontal:
            let height = heightSize(for: view,
                                    descriptor: descriptor,
                                    model: model,
                                    in: container,
                                    at: indexPath,
                                    alternativeSize: alternativeSize(for: .height))
            
            let width = widthSize(for: view,
                                  descriptor: descriptor,
                                  model: model,
                                  in: container,
                                  at: indexPath,
                                  alternativeSize: alternativeSize(for: .width, with: CGSize(width: containerSize.width, height: height)))
            
            return CGSize(width: width, height: height)
            
        @unknown default:
            return .zero
        }
    }
}

private extension SplittedSize {
    func alternativeSize(for dimension: SizeDimension, with proposedSize: CGSize? = nil) -> Sizeable {
        switch dimension {
        case .width:
            return widthSize ?? AutolayoutSize(proposedContainerSize: proposedSize)
            
        case .height:
            return heightSize ?? AutolayoutSize(proposedContainerSize: proposedSize)
        }
    }
    
    func widthSize<View: UIView>(for view: View,
                                 descriptor: Descriptor,
                                 model: AnyHashable,
                                 in container: UIScrollView,
                                 at indexPath: IndexPath,
                                 alternativeSize: Sizeable) -> CGFloat {
        let widthSpacing = itemsSpacing(for: .width, in: container, at: indexPath)
        let containerSize = adjustedSize(for: container, at: indexPath)
        
        if let segments = numOfElementsInWidth {
            let totalWidthSpacing = widthSpacing * (segments - 1)
            return (containerSize.width - totalWidthSpacing) / segments
        }
        
        return alternativeSize.size(for: view, descriptor: descriptor, model: model, in: container, at: indexPath).width
    }
    
    func heightSize<View: UIView>(for view: View,
                                  descriptor: Descriptor,
                                  model: AnyHashable,
                                  in container: UIScrollView,
                                  at indexPath: IndexPath,
                                  alternativeSize: Sizeable) -> CGFloat {
        let containerSize = adjustedSize(for: container, at: indexPath)
        let heightSpacing = itemsSpacing(for: .height, in: container, at: indexPath)

        if let segments = numOfElementsInHeight {
            let totalHeightSpacing = heightSpacing * (segments - 1)
            return (containerSize.height - totalHeightSpacing) / segments
        }
        
        return alternativeSize.size(for: view, descriptor: descriptor, model: model, in: container, at: indexPath).height
    }
}
