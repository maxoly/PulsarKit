//
//  PageControlPlugin.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

open class PageControlPlugin {
    public let pageControl: UIPageControl
    
    public init(pageControl: UIPageControl) {
        self.pageControl = pageControl
    }
}

extension PageControlPlugin: SourcePlugin {
    public func activate() {}
    
    public func deactivate() {}
    
    public var filter: SourcePluginFilter? {
        return self
    }
}

extension PageControlPlugin: SourcePluginFilter {
    public func containerDidScroll(_ container: UIScrollView) {
        guard let collectionView = container as? UICollectionView else { return }
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        if layout.scrollDirection == .horizontal {
            let visibleRect = CGRect(origin: container.contentOffset, size: container.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
            pageControl.currentPage = visibleIndexPath?.row ?? 0
        }
    }
}
