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
        let insertIcon = UIImage(named: "plus-square-regular")?.withRenderingMode(.alwaysTemplate)
        let insertItem = MenuItem(icon: insertIcon, title: "Insert", description: Constants.Lorem) {
            let controller = InsertViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let deleteIcon = UIImage(named: "eraser-solid")?.withRenderingMode(.alwaysTemplate)
        let deleteItem = MenuItem(icon: deleteIcon, title: "Delete", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let moveIcon = UIImage(named: "arrows-alt-solid")?.withRenderingMode(.alwaysTemplate)
        let movingItem = MenuItem(icon: moveIcon, title: "Move", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
  
        let pluginIcon = UIImage(named: "plug-solid")?.withRenderingMode(.alwaysTemplate)
        let pluginItem = MenuItem(icon: pluginIcon, title: "Plugins", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        
        let binderIcon = UIImage(named: "puzzle-piece-solid")?.withRenderingMode(.alwaysTemplate)
        let binderItem = MenuItem(icon: binderIcon, title: "Binders", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let sizesIcon = UIImage(named: "ruler-solid")?.withRenderingMode(.alwaysTemplate)
        let sizesItem = MenuItem(icon: sizesIcon, title: "Sizes", description: Constants.Lorem) {
            let controller = MoveViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.sections.add(element: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [insertItem, deleteItem, movingItem])
        source.sections.add(element: SourceSection(headerModel: Header(title: "Advanced")))
        source.add(models: [pluginItem, binderItem, sizesItem])
    }
}
