//
//  InfiniteScrollingPlugin.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 27/02/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

open class InfiniteScrollingPlugin: SourcePlugin {
    public typealias Callback = (CollectionSource) -> Void
    
    public var onReachedTheEnd: Callback
    public var threshold: Int
    
    public init(threshold: Int = 1, onReachedTheEnd: @escaping Callback) {
        self.threshold = threshold
        self.onReachedTheEnd = onReachedTheEnd
    }
}

extension InfiniteScrollingPlugin: SourcePluginEvents {
    public var filter: SourcePluginFilter? { nil }
    public var events: SourcePluginEvents? { self }
    public var lifecycle: SourcePluginLifecycle? { nil }
    
    public func dispatch(source: CollectionSource, event: Event.Display, context: CellContext<AnyHashable, UICollectionViewCell>) {
        guard event == .onWillDisplay else { return }
        
        let indexPath = context.indexPath
        let sections = source.sections
        
        // Section check
        guard indexPath.section == sections.count - 1 else { return }
        
        // Row check
        let section = sections[indexPath.section]
        let finalThreshold = min(threshold, section.models.count)
        guard indexPath.row == section.models.count - finalThreshold else { return }
        
        onReachedTheEnd(source)
    }
}
