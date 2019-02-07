//
//  PluginTests.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 29/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import XCTest
@testable import PulsarKit

class PluginTests: XCTestCase {
    func testPluginLifecycle() {
        // Arrange
        let plugin = TestPlugin()
        
        // Act
        autoreleasepool {
            let source = CollectionSource()
            source.add(plugin: plugin)
        }
        
        // Assert
        XCTAssertTrue(plugin.activated)
        XCTAssertTrue(plugin.deactivated)
    }
}
