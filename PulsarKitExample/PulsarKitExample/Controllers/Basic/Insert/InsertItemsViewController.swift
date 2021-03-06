//
//  InsertItemsViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 04/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class InsertItemsViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add/insert items"
        populateSource()
        addButton()
    }
    
    @objc
    func addButtonDidTouch(_ sender: Any) {
        source.add(model: User(id: 400, name: "User 400"))
        source.insert(model: User(id: 300, name: "User 300"), at: 2)
        source.insert(model: User(id: 301, name: "User 301"), at: 4)
        source.update()
    }
}

extension InsertItemsViewController {
    func populateSource() {
        UserProvider.getUsers { users in
            self.source.add(models: users)
            self.source.update()
        }
    }
    
    func addButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addButtonDidTouch(_:)))
    }
}
