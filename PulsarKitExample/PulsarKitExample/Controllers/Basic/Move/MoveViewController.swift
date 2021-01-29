//
//  MoveViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class MoveViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Move"
        populateSource()
    }
}

extension MoveViewController {
    func populateSource() {
        let itemsMenuItem = MenuItem(icon: UIImage.itemsMove, title: "Move Items", description: Constants.Lorem) {
            let controller = MoveItemsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let sectionsMenuItem = MenuItem(icon: UIImage.sectionsMove, title: "Move Sections", description: Constants.Lorem) {
            let controller = MoveSectionsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.add(section: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [itemsMenuItem, sectionsMenuItem])
    }
}
