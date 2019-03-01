//
//  MenuItem.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 27/02/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

struct MenuItem: Hashable {
    let icon: UIImage?
    let title: String
    let description: String
    let action: () -> Void
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
    }
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
