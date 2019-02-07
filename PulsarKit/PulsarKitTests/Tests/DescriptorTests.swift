//
//  DescriptorTests.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 24/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation
import XCTest
@testable import PulsarKit

class DescriptorTests: XCTestCase {
    func testCreatesCellFromDescriptor() {
        // Arrange
        let source = CollectionSource()
        let user = User(id: 1)
        
        // Act
        source.when(User.self).use(User1CollectionViewCell.self).withCellBinder()
        guard let descriptor = source.descriptor(for: user) else { return XCTFail("Invalid descriptor") }
        let cell = source.cell(for: descriptor)
        let cellCached = source.cell(for: descriptor)
        
        // Assert
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cellCached)
        XCTAssertEqual(cell, cellCached)
    }
    
    func testGetDescriptorByModel() {
        // Arrange
        let source = CollectionSource()
        let user1 = User(id: 1)
        let user2: AnyHashable = User(id: 2)
        let user3: AnyHashable = AnyHashable(User(id: 3))
        let user4: AnyHashable = AnyHashable(AnyHashable(User(id: 4)))
        
        // Act
        source.when(User.self).use(User1CollectionViewCell.self).withCellBinder()
        let descriptor1 = source.descriptor(for: user1)
        let descriptor2 = source.descriptor(for: user2)
        let descriptor3 = source.descriptor(for: user3)
        let descriptor4 = source.descriptor(for: user4)
        
        // Assert
        XCTAssertNotNil(descriptor1)
        XCTAssertNotNil(descriptor2)
        XCTAssertNotNil(descriptor3)
        XCTAssertNotNil(descriptor4)
    }
    
    func testAddDescriptor_FluentInterface() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.when(User.self).use(User1CollectionViewCell.self).withCellBinder()
        source.when(Product.self).use(ProductCollectionViewCell.self).withModelBinder()
        
        // Assert
        XCTAssertEqual(source.descriptors.count, 2)
    }
    
    func testAddMultipleDescriptorsForSameModel_FluentInterface() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.when(User.self).use(User1CollectionViewCell.self).withoutBinder()
        source.when(User.self).use(User1CollectionViewCell.self).withCellBinder() // replace prev.
        source.when(Product.self).use(ProductCollectionViewCell.self).withModelBinder()
        
        // Assert
        XCTAssertEqual(source.descriptors.count, 2)
    }
    
    func testAddCustomDescriptor() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.add(descriptor: MyCustomDescriptor())
        
        // Assert
        XCTAssertEqual(source.descriptors.count, 1)
    }
    
    func testCustomBinder() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.when(User.self).use(ProductCollectionViewCell.self).with(binder: MyCustomBinder())
        
        // Assert
        XCTAssertEqual(source.descriptors.count, 1)
    }
    
    func testRemoveDescriptor() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.when(User.self).use(User1CollectionViewCell.self).withCellBinder()
        source.when(Product.self).use(ProductCollectionViewCell.self).withModelBinder()
        guard let descriptor = source.descriptor(for: User.self) else {
            XCTFail("Invalid descriptor")
            return
        }
        
        source.remove(descriptor: descriptor)
        
        // Assert
        XCTAssertEqual(source.descriptors.count, 1)
    }
    
    func testRemoveDescriptorByModel() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.when(User.self).use(User1CollectionViewCell.self).withCellBinder()
        source.when(Product.self).use(ProductCollectionViewCell.self).withModelBinder()
        source.removeDescriptor(for: User.self)
        
        // Assert
        XCTAssertEqual(source.descriptors.count, 1)
    }
    
    func testGetCellConfiguration() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        source.when(User.self).use(User1CollectionViewCell.self).withoutBinder()
        
        // Assert
        XCTAssertNotNil(source.configuration(for: User.self, cell: User1CollectionViewCell.self))
    }
}
