//
//  MoveItemsViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 25/10/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

class MoveItemsViewController: PulsarKit.CollectionSourceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Move Items"
        prepareSource()
        populateWithUsers()
        forthMoveButton()
    }
    
    @objc
    func moveForthButtonDidTouch(_ sender: Any) {
        let from = IndexPath(item: 2, section: 0)
        let to = IndexPath(item: 1, section: 2)
        
        source.move(from: from, to: to)
        source.update()
        backMoveButton()
    }
    
    @objc
    func moveBackButtonDidTouch(_ sender: Any) {
        let from = IndexPath(item: 1, section: 2)
        let to = IndexPath(item: 2, section: 0)
        
        source.move(from: from, to: to)
        source.update()
        forthMoveButton()
    }
}

extension MoveItemsViewController {
    func prepareSource() {
        collectionView.backgroundColor = .tableGray
        source.when(User.self).use(UserCollectionViewCell.self).withModelBinder()
        source.when(Space.self).use(SpaceCollectionViewCell.self).withoutBinder()
        source.when(Header.self).use(SectionCollectionReusableView.self).withCellBinder()
    }
    
    func backMoveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(moveBackButtonDidTouch(_:)))
    }
    
    func forthMoveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Forth",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(moveForthButtonDidTouch(_:)))
    }
}
