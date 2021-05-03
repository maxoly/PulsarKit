//
//  FractionalSize.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/05/21.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import Foundation

public enum FractionalDimension {
    case fractionalWidth(CGFloat)
    case fractionalHeight(CGFloat)
}

public struct FractionalSize: Sizeable {
    public let widthDimension: FractionalDimension
    public let heightDimention: FractionalDimension
    public let offset: UIOffset
    
    public init(widthDimension: FractionalDimension = .fractionalWidth(0), heightDimention: FractionalDimension = .fractionalHeight(0), offset: UIOffset = .zero) {
        self.offset = offset
        self.widthDimension = widthDimension
        self.heightDimention = heightDimention
    }
    
    public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView, at indexPath: IndexPath) -> CGSize {
        let contentSize = adjustedSize(for: container, at: indexPath)
        
        let width = value(from: widthDimension, in: contentSize, offset: offset.horizontal)
        let height = value(from: heightDimention, in: contentSize, offset: offset.vertical)
        
        return CGSize(width: width.rounded(), height: height)
    }
}

private extension FractionalSize {
    func value(from dimension: FractionalDimension, in contentSize: CGSize, offset: CGFloat) -> CGFloat {
        switch dimension {
        case .fractionalWidth(let value):
            return (contentSize.width * value).rounded(.toNearestOrEven) - offset
            
        case .fractionalHeight(let value):
            return (contentSize.height * value).rounded(.toNearestOrEven) - offset
        }
    }
}
