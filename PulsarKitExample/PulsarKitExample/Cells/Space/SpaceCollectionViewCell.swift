//
//  SpaceCollectionViewCell.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 25/10/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class SpaceCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
}

extension SpaceCollectionViewCell: Sizeable {
    func size<View>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize where View: UIView {
        guard let space = model as? Space else { return .zero }
        return CompositeSize(heightSize: FixedSize(height: space.height)).size(for: view, descriptor: descriptor, model: model, in: container)
    }    
}
