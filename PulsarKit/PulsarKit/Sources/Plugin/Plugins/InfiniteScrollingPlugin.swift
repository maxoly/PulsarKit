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
    public var offset: Int
    
    public init(offset: Int = 1, onReachedTheEnd: @escaping Callback) {
        self.offset = offset
        self.onReachedTheEnd = onReachedTheEnd
    }
}

extension InfiniteScrollingPlugin: SourcePluginEvents {
    public var filter: SourcePluginFilter? { return nil }
    public var events: SourcePluginEvents? { return self }
    public var lifecycle: SourcePluginLifecycle? { return nil }
    
    public func dispatch(source: CollectionSource, event: Event.Display, context: CellContext<AnyHashable, UICollectionViewCell>) {
        guard event == .onWillDisplay else { return }
        
        let indexPath = context.indexPath
        let sections = source.sections
        
        // section check
        guard indexPath.section == sections.count - 1 else { return }
        
        // row check
        let section = sections[indexPath.section]
        let finalOffset = min(offset, section.models.count)
        guard indexPath.row == section.models.count - finalOffset else { return }
        
        onReachedTheEnd(source)
    }
}
