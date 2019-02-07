//
//  UserCollectionViewCell.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var reuseIdentifier: String? {
        return "UserCollectionViewCell"
    }
}
