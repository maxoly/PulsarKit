//
//  UICollectionView.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit

public extension UICollectionView {
    class var standard: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
}
