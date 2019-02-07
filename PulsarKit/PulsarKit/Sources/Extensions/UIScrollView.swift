//
//  UIScrollView.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 16/09/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation

extension UIScrollView {
    var sectionInset: UIEdgeInsets {
        guard let collectionView = self as? UICollectionView else { return .zero }
        guard let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        return flow.sectionInset
    }
}
