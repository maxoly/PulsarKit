//
//  SourcePluginLifecycle.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol SourcePluginLifecycle {
    func activate(in container: UIScrollView)
    func deactivate()
}
