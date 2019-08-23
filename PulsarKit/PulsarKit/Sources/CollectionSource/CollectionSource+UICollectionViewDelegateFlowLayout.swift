//
//  CollectionSource+UICollectionViewDelegateFlowLayout.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionSource: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = self.model(at: indexPath)
        return size(for: model, in: collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let section = sections[section]
        if let layout = section.layout { return layout.inset }
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout { return flow.sectionInset }
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let section = sections[section]
        if let layout = section.layout { return layout.minimumLineSpacing }
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout { return flow.minimumLineSpacing }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let section = sections[section]
        if let layout = section.layout { return layout.minimumInteritemSpacing }
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout { return flow.minimumInteritemSpacing }
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let model = sections[section].headerModel else { return .zero }
        return size(for: model, in: collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let model = sections[section].footerModel else { return .zero }
        return size(for: model, in: collectionView)

    }
}

extension CollectionSource {
    var scrollDirection: UICollectionView.ScrollDirection {
        if let flow = container.collectionViewLayout as? UICollectionViewFlowLayout {
            return flow.scrollDirection
        }
        return .vertical
    }
    
    func size(for model: AnyHashable, in collectionView: UICollectionView) -> CGSize {
        guard let descriptor = descriptor(for: model) else { return .zero }
        
        // check size cache
        let dimension = scrollDirection == .vertical ? container.bounds.size.width : container.bounds.size.height
        let key = "\(type(of: descriptor.cellClass)).\(dimension).\(model.hashValue)"
        let value = sizeCache.object(forKey: key as NSString)
        if let size = value?.cgSizeValue {
            return size
        }
        
        // new size
        guard let cell: UICollectionReusableView = cell(for: descriptor) else { return CGSize.zero }
        let sizeable = descriptor.size(for: model, cell: cell)
        let size = sizeable.size(for: cell, descriptor: descriptor, model: model, in: collectionView)
        
        // caches new size
        let cacheValue = NSValue(cgSize: size)
        sizeCache.setObject(cacheValue, forKey: key as NSString)
        
        // return
        return size
    }
}
