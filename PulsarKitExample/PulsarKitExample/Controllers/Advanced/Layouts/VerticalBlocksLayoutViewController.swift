//
//  VerticalBlocksLayoutViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 29/01/2021.
//  Copyright © 2021 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class VerticalBlocksLayoutViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Vertical blocks layout"
        populateSource()
    }
}

extension VerticalBlocksLayoutViewController {
    func populateSource() {
        source.configuration(for: Block.self, cell: BlockCollectionViewCell.self)?
            .set(sizeable: SplittedSize(numOfElementsInWidth: 2, heightSize: FixedSize(height: 100)))
        
        let blocks = (0..<100).map { index in
            Block(title: "\(Constants.Lorem) \(index)", textColor: .bright, backgroundColor: .secondary)
        }
        
        let layout = SourceSection.Layout(inset: .init(top: 20, left: 20, bottom: 20, right: 20), minimumLineSpacing: 35, minimumInteritemSpacing: 15)
        source.add(section: SourceSection(layout: layout))
        source.add(models: blocks)
    }
}
