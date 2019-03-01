//
//  SectionCollectionReusableView.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 06/10/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class SectionCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .secondary
        backgroundColor = .clear
    }
}

extension SectionCollectionReusableView: Bindable {
    func bind(to element: Header) {
        titleLabel.text = element.title
    }
}
