//
//  MovingViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 25/10/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

class MovingViewController: PulsarKit.CollectionSourceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forthMoveButton()
        
        collectionView.backgroundColor = .lightGray
        
        source.when(User.self).use(UserCollectionViewCell.self).withModelBinder()
        source.when(Space.self).use(SpaceCollectionViewCell.self).withCellBinder()
        
        source.sections.add()
        source.add(element: User(id: 1, name: "John 1"))
        source.add(element: User(id: 2, name: "John 2"))
        source.add(element: User(id: 3, name: "John 3"))  // ->>
        source.add(element: User(id: 1, name: "John 4"))
        source.add(element: User(id: 2, name: "John 5"))
        source.add(element: User(id: 3, name: "John 6"))
        
        source.sections.add()
        source.add(element: Space(height: 30))
        
        source.sections.add()
        source.add(element: User(id: 4, name: "Smith 1"))
        source.add(element: User(id: 5, name: "Smith 2"))  // <<-
        source.add(element: User(id: 6, name: "Smith 3"))
    }
    
    func backMoveButton() {
        let moveButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(moveBackButtonDidTouch(_:)))
        navigationItem.rightBarButtonItem = moveButton
    }
    
    func forthMoveButton() {
        let moveButton = UIBarButtonItem(title: "Forth", style: .done, target: self, action: #selector(moveForthButtonDidTouch(_:)))
        navigationItem.rightBarButtonItem = moveButton
    }
    
    @IBAction func moveForthButtonDidTouch(_ sender: Any) {
        let from = IndexPath(item: 2, section: 0)
        let to = IndexPath(item: 1, section: 2)
        
        source.move(from: from, to: to)
        source.update()
        backMoveButton()
    }
    
    @IBAction func moveBackButtonDidTouch(_ sender: Any) {
        let from = IndexPath(item: 1, section: 2)
        let to = IndexPath(item: 2, section: 0)
        
        source.move(from: from, to: to)
        source.update()
        forthMoveButton()
    }
}
