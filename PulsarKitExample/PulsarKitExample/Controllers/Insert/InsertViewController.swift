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
        let addItemMenu = MenuItem(icon: UIImage.moveSection, title: "Add new item", description: Constants.Lorem) {
            let controller = MoveItemsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        
        let inserRowMenu = MenuItem(icon: UIImage.moveSection, title: "Insert new item", description: Constants.Lorem) {
            let controller = MoveSectionsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        
        let addSectionMenu = MenuItem(icon: UIImage.moveSection, title: "Add new section", description: Constants.Lorem) {
            let controller = MoveItemsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let insertSectionMenu = MenuItem(icon: UIImage.moveSection, title: "Insert new section", description: Constants.Lorem) {
            let controller = MoveSectionsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.sections.add(element: SourceSection(headerModel: Header(title: "Items")))
        source.add(models: [addItemMenu, inserRowMenu])
        
        source.sections.add(element: SourceSection(headerModel: Header(title: "Sections")))
        source.add(models: [addSectionMenu, insertSectionMenu])
    }
}
