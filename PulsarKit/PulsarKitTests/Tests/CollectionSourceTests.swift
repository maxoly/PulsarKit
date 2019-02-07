//
//  PulsarKitTests.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import XCTest
@testable import PulsarKit

class CollectionSourceTests: XCTestCase {
    func testInit() {
        let container = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let source = CollectionSource(container: container)
        
        XCTAssert(source.container === container)
        XCTAssertEqual(source.models.count, 0)
        XCTAssertEqual(source.plugins.count, 0)
        XCTAssertEqual(source.sections.count, 0)
    }
    
    func testCounters() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.update()
        
        // Assert
        XCTAssertEqual(source.models.count, 0)
        XCTAssertEqual(source.sections.count, 0)
    }
    
    func testUpdateInMainThread() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        let exp = expectation(description: "thread")
        DispatchQueue.global().async {
            source.update { _ in
                if Thread.isMainThread {
                    exp.fulfill()
                }
            }
        }
        
        // Assert
        wait(for: [exp], timeout: 5)
    }
}
