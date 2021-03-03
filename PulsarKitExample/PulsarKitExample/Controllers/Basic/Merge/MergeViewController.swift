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
    let section1 = SourceSection()
    let section2 = SourceSection()
    
    var elements1: [AnyHashable] = [
        User(id: 1, name: "User 1"),
        User(id: 2, name: "User 2"),
        User(id: 3, name: "User 3"),
        User(id: 4, name: "User 4")
    ]
    
    var mergeElements1 = [
        User(id: 2, name: "User 2\n(reloaded)"),
        User(id: 21, name: "User 2.1\n(new)"),
        User(id: 4, name: "User 4\n(reloaded)"),
        User(id: 6, name: "User 6\n(new)"),
        User(id: 7, name: "User 7\n(new)")
    ]
    
    var elements2 = [
        User(id: 100, name: "User 100"),
        User(id: 200, name: "User 200"),
        User(id: 300, name: "User 300"),
        User(id: 400, name: "User 400")
    ]
    
    var mergeElements2 = [
        User(id: 200, name: "User 200\n(reloaded)"),
        User(id: 2100, name: "User 200.1\n(new)"),
        User(id: 400, name: "User 400\n(reloaded)"),
        User(id: 600, name: "User 600\n(new)"),
        User(id: 700, name: "User 700\n(new)")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Merge"
        populateSource()
        populateNavigationBar()
    }
    
    @objc
    func mergeButtonDidTouch(_ sender: Any) {
        section1.merge(models: mergeElements1)
        section2.merge(models: mergeElements2)
        source.update(invalidateLayout: true)
    }
}

extension MergeViewController {
    func populateSource() {
        source.add(section: section1)
        source.add(section: section2)
        
        section1.add(models: elements1)
        section2.add(models: elements2)
    }
    
    func populateNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize,
                                                            target: self,
                                                            action: #selector(mergeButtonDidTouch(_:)))
    }
}
