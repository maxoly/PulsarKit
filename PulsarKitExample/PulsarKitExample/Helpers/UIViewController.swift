//
//  UIViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

extension CollectionSourceViewController {
    func populateWithUsers() {
        source.add(section: SourceSection(headerModel: Header(title: "Section 1")))
        source.add(model: User(id: 1, name: "John 1"))
        source.add(model: User(id: 2, name: "John 2"))
        source.add(model: User(id: 3, name: "John 3"))
        source.add(model: User(id: 4, name: "John 4"))
        source.add(model: User(id: 5, name: "John 5"))
        source.add(model: User(id: 6, name: "John 6"))
        
        source.add(section: SourceSection(headerModel: Header(title: "Section 2")))
        source.add(model: User(id: 7, name: "John 7"))
        
        source.add(section: SourceSection(headerModel: Header(title: "Section 3")))
        source.add(model: User(id: 8, name: "John 8"))
        source.add(model: User(id: 9, name: "John 9"))
        source.add(model: User(id: 10, name: "John 10"))
    }
}
