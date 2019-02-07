//
//  TestPlugin.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 29/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation
import PulsarKit

class TestPlugin: SourcePlugin {
    var filter: SourcePluginFilter?
    
    var activated: Bool = false
    var deactivated: Bool = false
    
    func activate() {
        activated = true
    }
    
    func deactivate() {
        deactivated = true
    }
}