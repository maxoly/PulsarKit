//
//  UserCollectionViewCell.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class UserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userLabel: UILabel!
}

extension UserCollectionViewCell: Sizeable {
    func size<View>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize where View: UIView {
        return CGSize(width: container.bounds.width, height: 50)
    }
}
