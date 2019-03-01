//
//  SourcePluginEvents.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol SourcePluginEvents {
    func dispatch(source: CollectionSource, event: Event.Scroll, context: ScrollContext)
    func dispatch(source: CollectionSource, event: Event.Selection, context: StandardContext<AnyHashable>)
    func dispatch(source: CollectionSource, event: Event.Should, context: StandardContext<AnyHashable>) -> Bool?
    func dispatch(source: CollectionSource, event: Event.Display, context: CellContext<AnyHashable, UICollectionViewCell>)
    func dispatch(source: CollectionSource, event: Event.Menu, context: ActionContext<AnyHashable>) -> Bool?
    func dispatch(source: CollectionSource, from fromLayout: UICollectionViewLayout, to toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout?
}

public extension SourcePluginEvents {
    func dispatch(source: CollectionSource, event: Event.Scroll, context: ScrollContext) {}
    func dispatch(source: CollectionSource, event: Event.Selection, context: StandardContext<AnyHashable>) {}
    func dispatch(source: CollectionSource, event: Event.Should, context: StandardContext<AnyHashable>) -> Bool? { return nil }
    func dispatch(source: CollectionSource, event: Event.Display, context: CellContext<AnyHashable, UICollectionViewCell>) {}
    func dispatch(source: CollectionSource, event: Event.Menu, context: ActionContext<AnyHashable>) -> Bool? { return nil }
    func dispatch(source: CollectionSource, from fromLayout: UICollectionViewLayout, to toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout? { return nil }
}
