//
//  SourceEvents.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 29/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public typealias SourceEventHandler<M: Hashable> = (StandardContext<M>) -> Void
public typealias SourceEventResult<M: Hashable> = (StandardContext<M>) -> Bool
public typealias SourceEventCell<M: Hashable, C: UICollectionReusableView> = (CellContext<M, C>) -> Void
public typealias SourceEventPerformAction<M: Hashable> = (ActionContext<M>) -> Void
public typealias SourceEventCanPerformAction<M: Hashable> = (ActionContext<M>) -> Bool
public typealias SourceEventTransitionLayout = (UICollectionViewLayout, UICollectionViewLayout) -> UICollectionViewTransitionLayout?

public enum Event {
    public enum Selection {
        case onDidSelect
        case onDidDeselect
        case onDidHighlight
        case onDidUnhighlight
    }
    
    public enum Should {
        case onShouldHighlight
        case onShouldSelect
        case onShouldDeselect
    }
    
    public enum Display {
        case onWillDisplay
        case onDidEndDisplaying
    }
    
    public enum Menu {
        case onShouldShowMenu
        case onCanPerformAction
        case onPerformAction
    }
}

public class CollectionEvents<Model: Hashable, Cell: UICollectionReusableView> {
    private var didSelect: SourceEventHandler<Model>?
    private var didDeselect: SourceEventHandler<Model>?
    private var didHighlight: SourceEventHandler<Model>?
    private var didUnhighlight: SourceEventHandler<Model>?
    private var shouldHighlight: SourceEventResult<Model>?
    private var shouldSelect: SourceEventResult<Model>?
    private var shouldDeselect: SourceEventResult<Model>?
    private var willDisplay: SourceEventCell<Model, Cell>?
    private var didEndDisplaying: SourceEventCell<Model, Cell>?
    private var shouldShowMenu: SourceEventResult<Model>?
    private var canPerformAction: SourceEventCanPerformAction<Model>?
    private var performAction: SourceEventPerformAction<Model>?
    private var transitionLayout: SourceEventTransitionLayout?

    public func didSelect(_ callback: @escaping SourceEventHandler<Model>) { didSelect = callback }
    public func didDeselect(_ callback: @escaping SourceEventHandler<Model>) { didDeselect = callback }
    public func didHighlight(_ callback: @escaping SourceEventHandler<Model>) { didHighlight = callback }
    public func didUnhighlight(_ callback: @escaping SourceEventHandler<Model>) { didUnhighlight = callback }
    public func shouldHighlight(_ callback: @escaping SourceEventResult<Model>) { shouldHighlight = callback }
    public func shouldSelect(_ callback: @escaping SourceEventResult<Model>) { shouldSelect = callback }
    public func shouldDeselect(_ callback: @escaping SourceEventResult<Model>) { shouldDeselect = callback }
    public func willDisplay(_ callback: @escaping SourceEventCell<Model, Cell>) { willDisplay = callback }
    public func didEndDisplaying(_ callback: @escaping SourceEventCell<Model, Cell>) { didEndDisplaying = callback }
    public func shouldShowMenu(_ callback: @escaping SourceEventResult<Model>) { shouldShowMenu = callback }
    public func canPerformAction(_ callback: @escaping SourceEventCanPerformAction<Model>) { canPerformAction = callback }
    public func performAction(_ callback: @escaping SourceEventPerformAction<Model>) { performAction = callback }
    public func transitionLayout(_ callback: @escaping SourceEventTransitionLayout) { transitionLayout = callback }
    
    internal func dispatch(event: Event.Selection, context: StandardContext<Model>) {
        switch event {
        case .onDidSelect:
            didSelect?(context)
            
        case .onDidDeselect:
            didDeselect?(context)
            
        case .onDidHighlight:
            didHighlight?(context)
            
        case .onDidUnhighlight:
            didUnhighlight?(context)
        }
    }
    
    internal func dispatch(event: Event.Should, context: StandardContext<Model>) -> Bool? {
        switch event {
        case .onShouldHighlight:
            return shouldHighlight?(context)
            
        case .onShouldSelect:
            return shouldSelect?(context)
            
        case .onShouldDeselect:
            return shouldDeselect?(context)
        }
    }
    
    internal func dispatch(event: Event.Display, context: CellContext<Model, Cell>) {
        switch event {
        case .onWillDisplay:
            willDisplay?(context)
            
        case .onDidEndDisplaying:
            didEndDisplaying?(context)
        }
    }
    
    internal func dispatch(event: Event.Menu, context: ActionContext<Model>) -> Bool? {
        switch event {
        case .onPerformAction:
            performAction?(context)
            return nil
            
        case .onCanPerformAction:
            return canPerformAction?(context)
            
        case .onShouldShowMenu:
            return shouldShowMenu?(context.standard)
        }
    }
    
    internal func dispatch(from fromLayout: UICollectionViewLayout, to toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout? {
        return transitionLayout?(fromLayout, toLayout)
    }
}
