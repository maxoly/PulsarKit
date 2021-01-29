//
//  UIScrollView.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 16/09/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public enum SizeDimension {
    case width
    case height
}

private let sizeCache: NSCache<UIScrollView, NSValue> = NSCache<UIScrollView, NSValue>()

public extension Sizeable {
    func scrollDirection(in container: UIScrollView) -> UICollectionView.ScrollDirection {
        guard let collectionView = container as? UICollectionView else { return .vertical }
        guard let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .vertical }
        return flow.scrollDirection
    }
    
    func adjustedSize(for container: UIScrollView, at indexPath: IndexPath, offset: UIEdgeInsets = .zero) -> CGSize {
        // Check cache
        let value = sizeCache.object(forKey: container)
        if let size = value?.cgSizeValue {
            return size
        }
        
        // Calculate size
        var bounds = container.safeAreaLayoutGuide.layoutFrame
        bounds = bounds.inset(by: container.contentInset)
        bounds = bounds.inset(by: getSectionInsets(for: container, at: indexPath.section))
        bounds = bounds.inset(by: offset)
        
        // Cache value
        let cacheValue = NSValue(cgSize: bounds.size)
        sizeCache.setObject(cacheValue, forKey: container)
        
        return bounds.size
    }
    
    func getSectionInsets(for container: UIScrollView, at sectionIndex: Int) -> UIEdgeInsets {
        guard let collectionView = container as? UICollectionView else { return .zero }
        if let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
            if let insets = delegate.collectionView?(collectionView, layout: collectionView.collectionViewLayout, insetForSectionAt: sectionIndex) {
                return insets
            }
        }
        
        guard let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        return flow.sectionInset
    }
    
    func itemsSpacing(for dimension: SizeDimension, in container: UIScrollView, at indexPath: IndexPath) -> CGFloat {
        guard let collectionView = container as? UICollectionView else { return .zero }
        guard let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        switch (dimension, flow.scrollDirection) {
        case (.width, .vertical), (.height, .horizontal):
            return getMinimumInteritemSpacing(in: collectionView, at: indexPath.section)
            
        case (.width, .horizontal), (.height, .vertical):
            return getMinimumLineSpacing(in: collectionView, at: indexPath.section)            
            
        @unknown default:
            return 0
        }
    }
    
    func getMinimumInteritemSpacing(in collectionView: UICollectionView, at sectionIndex: Int) -> CGFloat {
        if let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
            if let spacing = delegate.collectionView?(collectionView, layout: collectionView.collectionViewLayout, minimumInteritemSpacingForSectionAt: sectionIndex) {
                return spacing
            }
        }
        
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            return flow.minimumInteritemSpacing
        }
        
        return .zero
    }
    
    func getMinimumLineSpacing(in collectionView: UICollectionView, at sectionIndex: Int) -> CGFloat {
        if let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
            if let spacing = delegate.collectionView?(collectionView, layout: collectionView.collectionViewLayout, minimumLineSpacingForSectionAt: sectionIndex) {
                return spacing
            }
        }
        
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            return flow.minimumLineSpacing
        }
        
        return .zero
    }
}
