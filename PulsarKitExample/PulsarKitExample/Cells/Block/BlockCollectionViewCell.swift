//
//  BlockCollectionViewCell.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 29/01/2021.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class BlockCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boxView.layer.cornerRadius = 10
    }
}

extension BlockCollectionViewCell: Bindable {
    func bind(to element: Block) {
        titleLabel.text = element.title
        titleLabel.textColor = element.textColor
        boxView.backgroundColor = element.backgroundColor
    }
}
