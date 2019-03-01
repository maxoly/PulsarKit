//
//  MoveSectionsViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

class MoveSectionsViewController: PulsarKit.CollectionSourceViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Move Sections"
        forthMoveButton()
        prepareSource()
        populateWithUsers()
    }
 
    @objc
    func moveForthButtonDidTouch(_ sender: Any) {
        source.sections.move(from: 0, to: 2)
        source.update()
        backMoveButton()
    }
    
    @objc
    func moveBackButtonDidTouch(_ sender: Any) {
        source.sections.move(from: 2, to: 0)
        source.update()
        forthMoveButton()
    }
}

extension MoveSectionsViewController {
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
