//
//  Displayable.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 09/02/2021.
//

import UIKit

public protocol Displayable {
    func container(display: Event.Display, view: UICollectionViewCell)
}
