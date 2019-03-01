//
//  SourcePlugin.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 25/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public protocol SourcePlugin {
    var filter: SourcePluginFilter? { get }
    var events: SourcePluginEvents? { get }
    var lifecycle: SourcePluginLifecycle? { get }
}
