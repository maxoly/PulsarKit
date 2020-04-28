//
//  PageControlPlugin.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public final class PageControlPlugin {
    public let pageControl: UIPageControl
    
    public init(pageControl: UIPageControl) {
        self.pageControl = pageControl
    }
}

extension PageControlPlugin: SourcePlugin {
    public var filter: SourcePluginFilter? { nil }
    public var events: SourcePluginEvents? { self }
    public var lifecycle: SourcePluginLifecycle? { nil }
}

extension PageControlPlugin: SourcePluginEvents {
    public func dispatch(source: CollectionSource, event: Event.Scroll, context: ScrollContext) {
        guard event == .onDidScroll else { return }
        guard let layout = source.container.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        if layout.scrollDirection == .horizontal {
            let visibleRect = CGRect(origin: source.container.contentOffset, size: source.container.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            let visibleIndexPath = source.container.indexPathForItem(at: visiblePoint)
            pageControl.currentPage = visibleIndexPath?.row ?? 0
        }
    }
}
