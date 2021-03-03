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
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

extension User: Bindable {
    func bind(to element: UserCollectionViewCell) {
        element.userLabel.text = name
    }
}
