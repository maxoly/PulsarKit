//
//  SourcePlugin.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol SourcePlugin {
    func activate()
    func deactivate()
    
    var filter: SourcePluginFilter? { get }
}

public protocol SourcePluginFilter {
    func containerDidScroll(_ container: UIScrollView)
}

extension SourcePluginFilter {
    func containerDidScroll(_ container: UIScrollView) {}
}
