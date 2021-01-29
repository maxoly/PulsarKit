//
//  InsertViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class InsertViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Insert"
        populateSource()
    }
}

extension InsertViewController {    
    func populateSource() {
        let addItemMenu = MenuItem(icon: UIImage.addItems, title: "Add/insert new item", description: Constants.Lorem) {
            let controller = InsertItemsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let addSectionMenu = MenuItem(icon: UIImage.addSections, title: "Add/insert new section", description: Constants.Lorem) {
            let controller = InsertSectionsViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.add(section: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [addItemMenu, addSectionMenu])
    }
}
