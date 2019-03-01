//
//  HomeViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class HomeViewController: CollectionSourceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PulsarKit Demo"
        prepareSource()
        populateSource()
    }
}

extension HomeViewController {
    func prepareSource() {
        source.container.backgroundColor = .tableGray
        source.when(Space.self).use(SpaceCollectionViewCell.self).withoutBinder()
        source.when(MenuItem.self).use(MenuItemCollectionViewCell.self).withCellBinder()
        source.when(Header.self).use(SectionCollectionReusableView.self).withCellBinder()
        
        let conf = source.configuration(for: MenuItem.self, cell: MenuItemCollectionViewCell.self)
        conf?.on.didSelect { context in context.model.action() }
    }
    
    func populateSource() {
        let insertItem = MenuItem(icon: UIImage.insertIcon, title: "Insert", description: Constants.Lorem) {
            let controller = InsertViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let deleteItem = MenuItem(icon: UIImage.deleteIcon, title: "Delete", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let movingItem = MenuItem(icon: UIImage.moveIcon, title: "Move", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let pluginItem = MenuItem(icon: UIImage.pluginIcon, title: "Plugins", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let binderItem = MenuItem(icon: UIImage.binderIcon, title: "Binders", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let sizesItem = MenuItem(icon: UIImage.sizesIcon, title: "Sizes", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.add(section: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [insertItem, deleteItem, movingItem])
        
        source.add(section: SourceSection(headerModel: Header(title: "Advanced")))
        source.add(models: [pluginItem, binderItem, sizesItem])
        
        source.add(model: Space(height: 20))
    }
}
