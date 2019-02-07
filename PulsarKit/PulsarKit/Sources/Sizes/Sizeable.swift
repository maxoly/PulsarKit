//
//  Sizeable.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation

public protocol Sizeable {
    func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize
}
