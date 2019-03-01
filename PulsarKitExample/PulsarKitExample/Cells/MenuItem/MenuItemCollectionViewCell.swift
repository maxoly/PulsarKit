//
//  MenuItemCollectionViewCell.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 27/02/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .primary
        descriptionLabel.textColor = .secondary
        lineView.backgroundColor = .light
        iconImageView.tintColor = .primary
        backgroundColor = .white
    }
}

extension MenuItemCollectionViewCell: Bindable {
    func bind(to element: MenuItem) {
        titleLabel.text = element.title
        descriptionLabel.text = element.description
        iconImageView.image = element.icon
    }
}

extension MenuItemCollectionViewCell: Groupable {
    func groupNotification(sectionPosition: GroupedCollectionPlugin.Position, itemPosition: GroupedCollectionPlugin.Position) {
        print("section: \(sectionPosition), item: \(itemPosition)")
    }
}
