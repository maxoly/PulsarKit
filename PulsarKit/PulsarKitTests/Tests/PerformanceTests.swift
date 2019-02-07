//
//  PerformanceTests.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 14/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import XCTest
@testable import PulsarKit

class PerformanceTests: XCTestCase {

    func testAddSectionsPerformace() {
        measure {
            let source = CollectionSource()
            source.sections.add(quantity: 1_000)
            source.update()
        }
    }
    
    func testInsertSectionsPerformance() {
        measure {
            let source = CollectionSource()
            source.sections.insert(in: 0...1_000)
            source.update()
        }
    }

    func testDeleteSectionsPerformance() {
        let source = CollectionSource()
        source.sections.add(quantity: 1_000)
        source.update()
        
        measure {
            source.sections.deleteAll()
            source.update()
        }
    }
}
