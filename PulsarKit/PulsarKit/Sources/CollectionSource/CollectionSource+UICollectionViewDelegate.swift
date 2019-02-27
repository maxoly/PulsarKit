//
//  CollectionSource+UICollectionViewDelegate.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

extension CollectionSource: UICollectionViewDelegate {
    // MARK: selection
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dispatch(event: .onDidSelect, container: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        dispatch(event: .onDidDeselect, container: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        dispatch(event: .onDidHighlight, container: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        dispatch(event: .onDidUnhighlight, container: collectionView, indexPath: indexPath)
    }
    
    // MARK: should
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return dispatch(event: .onShouldHighlight, container: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return dispatch(event: .onShouldSelect, container: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return dispatch(event: .onShouldDeselect, container: collectionView, indexPath: indexPath)
    }
    
    // MARK: display
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        dispatch(event: .onWillDisplay, container: collectionView, cell: cell, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        dispatch(event: .onDidEndDisplaying, container: collectionView, cell: cell, indexPath: indexPath)
    }
    
    // MARK: menu
    public func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return dispatch(event: .onShouldShowMenu, container: collectionView, indexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return dispatch(event: .onCanPerformAction, container: collectionView, indexPath: indexPath, action: action, sender: sender)
    }
    
    public func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        _ = dispatch(event: .onPerformAction, container: collectionView, indexPath: indexPath, action: action, sender: sender)
    }
    
    // MARK: layout
    public func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        return on.dispatch(from: fromLayout, to: toLayout) ?? UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
    }
}

// MARK: - UIScrollViewDelegate
public extension CollectionSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let context = ScrollContext(container: scrollView)
        events.forEach { $0.dispatch(source: self, event: Event.Scroll.onDidScroll, context: context) }
    }
}
