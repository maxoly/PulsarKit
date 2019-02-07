//
//  User.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

struct User: Hashable {
    let id: Int
    let name: String
    
    init(id: Int, name: String = "") {
        self.id = id
        self.name = name
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    var hashValue: Int {
        return id.hashValue
    }
}

extension User: Bindable {
    func bind(to element: UserCollectionViewCell) {
        element.userLabel.text = name
    }
}
