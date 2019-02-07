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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension SpaceCollectionViewCell: Bindable {
    func bind(to element: Space) {
        heightConstraint.constant = element.height
    }
}
