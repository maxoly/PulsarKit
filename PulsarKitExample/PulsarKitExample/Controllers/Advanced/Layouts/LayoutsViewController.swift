//
//  LayoutsViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 29/01/2021.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class LayoutsViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Layouts"
        populateSource()
    }
}

extension LayoutsViewController {
    func populateSource() {
        let tableItem = MenuItem(icon: UIImage.addItems, title: "Table layout", description: Constants.Lorem) {
            let controller = TableLayoutViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let vblocksItem = MenuItem(icon: UIImage.itemsMove, title: "Vetical blocks layout", description: Constants.Lorem) {
            let controller = VerticalBlocksLayoutViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let hblocksItem = MenuItem(icon: UIImage.itemsMove, title: "Horizontal blocks layout", description: Constants.Lorem) {
            let controller = HorizontalBlocksLayoutViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.add(section: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [tableItem, vblocksItem, hblocksItem])
    }
}
