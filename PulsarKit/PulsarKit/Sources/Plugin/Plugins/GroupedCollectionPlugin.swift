//
//  GroupedCollectionPlugin.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol Groupable {
    func groupNotification(sectionPosition: GroupedCollectionPlugin.Position, itemPosition: GroupedCollectionPlugin.Position)
}

open class GroupedCollectionPlugin {
    public enum Position {
        case first
        case middle
        case last
        case single
    }
    
    public init() {}
}

extension GroupedCollectionPlugin: SourcePlugin {
    public var filter: SourcePluginFilter? { return self }
    public var events: SourcePluginEvents? { return nil }
    public var lifecycle: SourcePluginLifecycle? { return nil }
}

extension GroupedCollectionPlugin: SourcePluginFilter {
    public func filter<Cell>(source: CollectionSource, cell: Cell, at indexPath: IndexPath) -> Cell where Cell: UICollectionReusableView {
        guard let groupable = cell as? Groupable else { return cell }
        
        let sectionsCount = source.sections.count
        let modelCount = source.sections[indexPath.section].models.count
        
        let sectionPosition = position(count: sectionsCount, index: indexPath.section)
        let itemPosition = position(count: modelCount, index: indexPath.item)
        groupable.groupNotification(sectionPosition: sectionPosition, itemPosition: itemPosition)
        
        return cell
    }
}

private extension GroupedCollectionPlugin {
    func position(count: Int, index: Int) -> Position {
        switch (count, index) {
        case (1, _):
            return .single
            
        case (_, let rowIndex) where rowIndex == 0:
            return .first
            
        case (let rowsCount, let rowIndex) where rowIndex == (rowsCount - 1):
            return .last
            
        default:
            return .middle
        }
    }
}
