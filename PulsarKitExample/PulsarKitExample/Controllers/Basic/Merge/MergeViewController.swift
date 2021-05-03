//
//  MergeViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2021.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class MergeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Merge"
        populateSource()
    }
}

extension MergeViewController {
    func populateSource() {
        let itemsMenuItem = MenuItem(icon: UIImage.itemsMove, title: "Simple merge", description: Constants.Lorem) {
            let controller = SimpleMergeViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        let sectionsMenuItem = MenuItem(icon: UIImage.sectionsMove, title: "Search merge", description: Constants.Lorem) {
            let controller = SearchMergeViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
        source.add(section: SourceSection(headerModel: Header(title: "Basic")))
        source.add(models: [itemsMenuItem, sectionsMenuItem])
    }
}
