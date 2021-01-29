//
//  HorizontalBlocksLayoutViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 29/01/2021.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import Foundation
import UIKit
import PulsarKit

final class HorizontalBlocksLayoutViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Horizontal blocks layout"
        populateSource()
    }
}

extension HorizontalBlocksLayoutViewController {
    func populateSource() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        source.configuration(for: Block.self, cell: BlockCollectionViewCell.self)?
            .set(sizeable: SplittedSize(numOfElementsInWidth: 2, numOfElementsInHeight: 2))
        
        let blocks = (0..<100).map { index in
            Block(title: "\(Constants.Lorem) \(index)", textColor: .bright, backgroundColor: .secondary)
        }
        
        let layout = SourceSection.Layout(inset: .init(top: 20, left: 20, bottom: 20, right: 20), minimumLineSpacing: 30, minimumInteritemSpacing: 15)
        source.add(section: SourceSection(layout: layout))
        source.add(models: blocks)
    }
}
