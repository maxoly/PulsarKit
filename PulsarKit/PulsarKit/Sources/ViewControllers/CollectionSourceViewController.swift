//
//  CollectionSourceViewController.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/10/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit

open class CollectionSourceViewController: UIViewController {
    public lazy var source = CollectionSource(container: self.collectionView)
    
    // swiftlint:disable implicitly_unwrapped_optional
    public var collectionView: UICollectionView!
    public var collectionViewTopConstraint: NSLayoutConstraint!
    public var collectionViewBottomConstraint: NSLayoutConstraint!
    public var collectionViewLeadingConstraint: NSLayoutConstraint!
    public var collectionViewTrailingConstraint: NSLayoutConstraint!
    // swiftlint:enable implicitly_unwrapped_optional
    
    override open func loadView() {
        // View
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
        
        // Collection Layout
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        // Collection View
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        collectionViewBottomConstraint = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        collectionViewLeadingConstraint = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        collectionViewTrailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            collectionViewTopConstraint,
            collectionViewBottomConstraint,
            collectionViewLeadingConstraint,
            collectionViewTrailingConstraint
        ])
    }
}
