//
//  CollectionSourceViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

final class CellaCollectionViewCell: UICollectionViewCell, Bindable {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    public func bind(to element: User) {
        label1.text = element.name
        label2.text = "\(element.id)"
    }
}

struct Secion: Hashable {
    let id: String
}

class CollectionSourceViewController: UICollectionViewController {
    lazy var source = CollectionSource(container: collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        source.when(Secion.self).use(SectionCollectionReusableView.self).withCellBinder()
        let desc = source.when(User.self).use(UserCollectionViewCell.self).withModelBinder()

        //        .set(sizeable: CompositeSize(widthSize: ContainerSize(), heightSize: FixedSize(height: 54)))
        
//        let desc = source.when(User.self)
//            .useStoryboard(CellaCollectionViewCell.self)
//            .withCellBinder()
//            .set(sizeable: CompositeSize(widthSize: ContainerSize(), heightSize: FixedSize(height: 54)))
//
//        desc.set(sizeable: CompositeSize(widthSize: ContainerSize(), heightSize: FixedSize(height: 200)),
//                 for: User(id: 1))
        
        desc.on(model: User(id: 1)).didSelect { context in
            print("qui")

        }
        
        desc.on.didSelect { _ in
            print("quo")
        }
        
        source.on.didSelect { _ in
            print("qua")
        }
        
        source.sections.add(element: SourceSection(footerModel: Secion(id: "1")))
        
        for index in 0...100 {
            source.add(element: User(id: index, name: "Username \(index)"))
        }
    }
    
    @IBAction func deleteItems(_ sender: Any) {
        source.delete(in: 2...4)
        source.move(from: 0, to: 1)
        source.insert(element: User(id: 300, name: "Username 300"), at: 6)
        source.insert(element: User(id: 301, name: "Username 301"), at: 7)
        source.update()
    }
    
    @IBAction func move(_ sender: Any) {
        source.move(from: 4, to: 1)
        source.update()
    }
}
