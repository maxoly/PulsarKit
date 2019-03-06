//
//  InsertViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class InsertViewController: CollectionSourceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Insert"
        prepareSource()
        populateSource()
    }
}

extension InsertViewController {
    func prepareSource() {
        source.container.backgroundColor = .tableGray
        source.when(Space.self).use(SpaceCollectionViewCell.self).withoutBinder()
        source.when(MenuItem.self).use(MenuItemCollectionViewCell.self).withCellBinder()
        source.when(Header.self).use(SectionCollectionReusableView.self).withCellBinder()
        
        let conf = source.configuration(for: MenuItem.self, cell: MenuItemCollectionViewCell.self)
        conf?.on.didSelect { context in context.model.action() }
    }
    
    func populateSource() {
        let addItemMenu = MenuItem(icon: UIImage.addItems, title: "Add/insert new item", description: Constants.Lorem) {
            let controller = InsertItemsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
    
        
        let addSectionMenu = MenuItem(icon: UIImage.addSections, title: "Add/insert new section", description: Constants.Lorem) {
            let controller = MoveItemsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        
        source.add(section: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [addItemMenu, addSectionMenu])
    }
}
