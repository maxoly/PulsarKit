//
//  SectionTests.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation
import XCTest
@testable import PulsarKit

class SectionTests: XCTestCase {    
    func testAddSections() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        
        // Act
        for _ in 1...random { source.sections.add() }
        source.update()
        
        // Assert
        XCTAssertEqual(source.sections.count, random)
    }
    
    func testAddSectionsWithQuantity() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        
        // Act
        source.sections.add(quantity: random)
        source.update()
        
        // Assert
        XCTAssertEqual(source.sections.count, random)
    }
    
    func testtestAddSectionsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        source.sections.add(quantity: 4)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        source.sections.add(quantity: random)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
    }
    
    func testInsertSections() {
        // Arrange
        let source = CollectionSource()
        source.sections.add(quantity: 4)
        source.update()
        
        // Act
        let section3 = source.sections.insert(at: 3)
        let section1 = source.sections.insert(at: 1)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, 6)
        XCTAssert(source.sections[1] === section1)
        XCTAssert(source.sections[3] === section3)
    }
    
    func testInsertSectionsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        source.sections.add(quantity: 4)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        let section3 = source.sections.insert(at: 3)
        let section1 = source.sections.insert(at: 1)
        source.update { _ in
            exp.fulfill()
        }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssert(source.sections[1] === section1)
        XCTAssert(source.sections[3] === section3)
    }
    
    func testDeleteSections() {
        // Arrange
        let source = CollectionSource()
        let sections = source.sections.add(quantity: 5)
        source.update()
        
        // Act
        source.sections.delete(at: 3)
        source.sections.delete(at: 1)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, 3)
        XCTAssert(source.sections[0] === sections[0])
        XCTAssert(source.sections[1] === sections[2])
        XCTAssert(source.sections[2] === sections[4])
    }
    
    func testDeleteAllSections() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        source.sections.add(quantity: random)
        source.update()
        
        // Act
        source.sections.deleteAll()
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, 0)
    }
    
    func testDeleteAllAfterSections() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        source.sections.add(quantity: random)
        source.update()
        
        // Act
        let after = Int.random(in: 1...random)
        source.sections.deleteAll(after: after)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, after)
    }
    
    func testDeleteAllBeforeSections() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        source.sections.add(quantity: random)
        source.update()
        
        // Act
        let before = Int.random(in: 1..<random)
        source.sections.deleteAll(before: before)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, (random - before - 1))
    }
    
    func testDeleteRangeSections() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        let remove = Int.random(in: 0...random - 1)
        source.sections.add(quantity: random)
        source.update()
        
        // Act
        source.sections.delete(in: 0...remove)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, (random - remove - 1))
    }
    
    func testDeleteSectionsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let sections = source.sections.add(quantity: 5)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        source.sections.delete(at: 3)
        source.sections.delete(at: 1)
        source.update { _ in
            exp.fulfill()
        }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssert(source.sections[0] === sections[0])
        XCTAssert(source.sections[1] === sections[2])
        XCTAssert(source.sections[2] === sections[4])
    }
    
    func testMoveSections() {
        // Arrange
        let source = CollectionSource()
        let sections = source.sections.add(quantity: 5)
        source.update()
        
        // Act
        source.sections.move(from: 0, to: 3)
        source.sections.move(from: 1, to: 4)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, 5)
        XCTAssert(source.sections[1] === sections[3])
        XCTAssert(source.sections[2] === sections[4])
        XCTAssert(source.sections[3] === sections[0])
        XCTAssert(source.sections[4] === sections[1])
    }
    
    func testMoveSectionsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let sections = source.sections.add(quantity: 5)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        source.sections.move(from: 0, to: 3)
        source.sections.move(from: 1, to: 4)
        source.update { _ in
            exp.fulfill()
        }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssert(source.sections[0] === sections[2])
        XCTAssert(source.sections[1] === sections[3])
        XCTAssert(source.sections[2] === sections[4])
        XCTAssert(source.sections[3] === sections[0])
        XCTAssert(source.sections[4] === sections[1])
    }
    
    func testReloadSections() {
        // Arrange
        let source = CollectionSource()
        let sections = source.sections.add(quantity: 5)
        source.update()
        
        // Act
        source.sections.reload(at: 0)
        source.sections.reload(element: sections[1])
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, 5)
    }
    
    func testReloadSectionsInRange() {
        // Arrange
        let source = CollectionSource()
        source.sections.add(quantity: 5)
        source.update()
        
        // Act
        source.sections.reload(in: 0...3)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.sections.count, 5)
    }
    
    func testAllSectionsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let sections = source.sections.add(quantity: 5)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        source.sections.delete(at: 0)
        source.sections.delete(at: 1)
        source.sections.delete(at: 2)
        source.sections.move(from: 3, to: 4)
        let section0 = source.sections.insert(at: 0)
        let section1 = source.sections.insert(at: 1)
        let section2 = source.sections.insert(at: 2)
        let section5 = source.sections.add()
        let section6 = source.sections.add()
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.sections.count, 7)
        XCTAssert(source.sections[0] === section0)
        XCTAssert(source.sections[1] === section1)
        XCTAssert(source.sections[2] === section2)
        XCTAssert(source.sections[3] === sections[4])
        XCTAssert(source.sections[4] === sections[3])
        XCTAssert(source.sections[5] === section5)
        XCTAssert(source.sections[6] === section6)
    }
    
    func testFirstSection() {
        // Arrange
        let source = CollectionSource()
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        source.firstSection.footerModel = nil
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.sections.count, 1)
    }
    
    func testLastSection() {
        // Arrange
        let source = CollectionSource()
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        source.lastSection.footerModel = nil
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.sections.count, 1)
    }
    
    func testFirstEqualToLastSection() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        source.update()
        
        // Act
        let first = source.firstSection
        let last = source.lastSection
        
        // Assert
        XCTAssertEqual(section, first)
        XCTAssertEqual(section, last)
        XCTAssertEqual(source.sections.count, 1)
    }
    
    func testFirstIsNotEqualToLastSection() {
        // Arrange
        let source = CollectionSource()
        let sections = source.sections.add(quantity: 2)
        source.update()
        
        // Act
        let first = source.firstSection
        let last = source.lastSection
        
        // Assert
        XCTAssertEqual(sections[0], first)
        XCTAssertEqual(sections[1], last)
        XCTAssertNotEqual(first, last)
        XCTAssertEqual(source.sections.count, 2)
    }
}
