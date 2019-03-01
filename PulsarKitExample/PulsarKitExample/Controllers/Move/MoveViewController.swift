//
//  MoveViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

class MoveViewController: CollectionSourceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Move"
        prepareSource()
        populateSource()
    }
}

extension MoveViewController {
    func prepareSource() {
        source.container.backgroundColor = .tableGray
        source.when(Space.self).use(SpaceCollectionViewCell.self).withoutBinder()
        source.when(MenuItem.self).use(MenuItemCollectionViewCell.self).withCellBinder()
        source.when(Header.self).use(SectionCollectionReusableView.self).withCellBinder()
        
        let conf = source.configuration(for: MenuItem.self, cell: MenuItemCollectionViewCell.self)
        conf?.on.didSelect { context in context.model.action() }
    }
    
    func populateSource() {
        let itemsMoveIcon = UIImage(named: "grip-vertical-solid")?.withRenderingMode(.alwaysTemplate)
        let itemsMenuItem = MenuItem(icon: itemsMoveIcon, title: "Move Items", description: Constants.Lorem) {
            let controller = MoveItemsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let sectionsMoveIcon = UIImage(named: "object-ungroup-solid")?.withRenderingMode(.alwaysTemplate)
        let sectionsMenuItem = MenuItem(icon: sectionsMoveIcon, title: "Move Sections", description: Constants.Lorem) {
            let controller = MoveSectionsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.sections.add(element: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [itemsMenuItem, sectionsMenuItem])
    }
}
