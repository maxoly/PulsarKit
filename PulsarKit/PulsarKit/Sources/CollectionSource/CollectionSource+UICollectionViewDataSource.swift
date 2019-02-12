//
//  CollectionSource+UICollectionViewDataSource.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

extension CollectionSource: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        isFirstTime = false
        sections.recursiveReset()
        return sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].models.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = self.model(at: indexPath)
        
        guard let descriptor = descriptor(for: model) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptor.cellReuseIdentifier, for: indexPath)
        descriptor.bind(cell: cell, with: model)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let model = sections[indexPath.section].headerModel else { return UICollectionReusableView() }
            guard let descriptor = descriptor(for: model) else { return UICollectionReusableView() }
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: descriptor.cellReuseIdentifier, for: indexPath)
            descriptor.bind(cell: cell, with: model)
            return cell
        }
        
        if kind == UICollectionView.elementKindSectionFooter {
            guard let model = sections[indexPath.section].footerModel else { return UICollectionReusableView() }
            guard let descriptor = descriptor(for: model) else { return UICollectionReusableView() }
            
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: descriptor.cellReuseIdentifier, for: indexPath)
            descriptor.bind(cell: cell, with: model)
            return cell
        }
        
        return UICollectionReusableView()
    }
}
