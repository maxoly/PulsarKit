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

class CollectionSourceViewController1: UICollectionViewController {
    lazy var source = CollectionSource(container: collectionView)
    let specialUser1 = User(id: 1922, name: "SPECIAL USER")
    let specialUser2 = User(id: 1923, name: "PIPPO USER")
    
    lazy var infinite = InfiniteScrollingPlugin(offset: 10) { source in
        print("reach the end")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            for index in 200...300 {
                source.add(model: User(id: index, name: "Username \(index)"))
            }
            source.update()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        source.add(plugin: infinite)
        source.when(Header.self).use(SectionCollectionReusableView.self).withCellBinder()
        
        source.when(Header.self).use(SectionCollectionReusableView.self).with { (header, view) in
            view.titleLabel.text = header.title
        }
        
        let desc = source.when(User.self).use(UserCollectionViewCell.self).withModelBinder()
        
        let container = ContainerSize()
        let fixed = FixedSize(height: 50)
        let composite = CompositeSize(widthSize: container, heightSize: fixed)
        
        desc.set(sizeable: composite)

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
        
        desc.on.didSelect { context in
            print("model: \(context.model)")
            print("indexPath: \(context.indexPath)")
        }
        
        source.on.didSelect { context in
            print("model: \(context.model)")
            print("indexPath: \(context.indexPath)")
        }
        
        source.sections.add(element: SourceSection(footerModel: Header(title: "1")))
        
        source.add(model: specialUser1)
        source.add(model: specialUser1)
        source.add(model: specialUser1)
        source.add(model: specialUser2)
        source.add(model: specialUser2)
        
        for index in 0...100 {
            source.add(model: User(id: index, name: "Username \(index)"))
        }
    }
    
    @IBAction func deleteItems(_ sender: Any) {
        let array: [AnyHashable] = [specialUser1, specialUser2]
        source.delete(allInstancesOf: specialUser2)
        source.delete(allInstancesIn: array)
//        source.delete(in: 2...4)
        source.move(from: 10, to: 11)
//        source.reload(model: specialUser2)
        source.insert(model: User(id: 300, name: "Username 300"), at: 6)
        source.insert(model: User(id: 301, name: "Username 301"), at: 7)
        source.update()
    }
    
    @IBAction func move(_ sender: Any) {
        source.move(from: 4, to: 1)
        source.update()
    }
}
