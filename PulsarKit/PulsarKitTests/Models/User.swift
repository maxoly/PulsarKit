//
//  User.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 14/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

struct User: Hashable {
    let id: Int
    let name: String
    
    init(id: Int, name: String = "") {
        self.id = id
        self.name = name
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
