//
//  MenuViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 29/01/2021.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class BaseViewController: CollectionSourceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSource()
    }
}

extension BaseViewController {
    func prepareSource() {
        source.container.backgroundColor = .tableGray
        source.when(User.self).use(UserCollectionViewCell.self).withModelBinder()
        source.when(Space.self).use(SpaceCollectionViewCell.self).withoutBinder()
        source.when(MenuItem.self).use(MenuItemCollectionViewCell.self).withCellBinder()
        source.when(Header.self).use(SectionCollectionReusableView.self).withCellBinder()
        source.when(Block.self).use(BlockCollectionViewCell.self).withCellBinder()

        let conf = source.configuration(for: MenuItem.self, cell: MenuItemCollectionViewCell.self)
        conf?.on.didSelect { context in context.model.action() }
    }
}

