//
//  UICollectionViewDataSourceTests.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 14/09/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import XCTest
@testable import PulsarKit

class UICollectionViewDataSourceTests: XCTestCase {
    func testNumberOfSections() {
        // Arrange
        let source = CollectionSource()
        source.when(User.self).use(User1CollectionViewCell.self).withoutBinder()
        let random = Int.random(in: 1...100)
        
        // Act
        source.update(forceReload: true)
        let num0 = source.container.numberOfSections
        source.sections.add(quantity: random)
        source.update(forceReload: true)
        let num1 = source.container.numberOfSections
        
        // Assert
        XCTAssertEqual(num0, 0)
        XCTAssertEqual(num1, random)
    }
    
    func testNumberOfItemsInSections() {
        // Arrange
        let randomSection = Int.random(in: 1...100)
        let source = CollectionSource()
        source.when(User.self).use(User1CollectionViewCell.self).withoutBinder()
        source.sections.add(quantity: randomSection)
        
        // Act empty
        source.update(forceReload: true)
        let emptyNumberOfItems = (0..<randomSection).map { source.container.numberOfItems(inSection: $0) }
        
        // Act fill
        let addedModels = (0..<randomSection).map { sectionIndex -> Int in
            let random = Int.random(in: 1...100)
            (0..<random).forEach {
                source.sections[sectionIndex].models.add(element: User(id: $0))
            }
            return random
        }
        source.update(forceReload: true)
        let filledNumberOfItems = (0..<randomSection).map { source.container.numberOfItems(inSection: $0) }
        let zipped = zip(addedModels, filledNumberOfItems)
        
        // Assert
        emptyNumberOfItems.forEach { XCTAssertEqual($0, 0) }
        zipped.forEach { XCTAssertEqual($0.0, $0.1) }
    }
    
    func testCellForItemAtIndexPath() {
        // Arrange
        let source = CollectionSource()
        let container = source.container
        source.when(User.self).use(User1CollectionViewCell.self).withoutBinder()
        source.when(Product.self).use(ProductCollectionViewCell.self).withoutBinder()
        let sections = source.sections.add(quantity: 3)
        
        // Act
        sections[1].models.add(element: User(id: 1))
        sections[1].models.add(element: Product(id: 1))
        sections[1].models.add(element: User(id: 2))
        
        sections[2].models.add(element: Product(id: 1))
        sections[2].models.add(element: Product(id: 1))
        sections[2].models.add(element: User(id: 2))
        
        source.update(forceReload: true)
        
        // Assert
        XCTAssertNil(container.cellForItem(at: IndexPath(item: 0, section: 0)))
        guard source.collectionView(container, cellForItemAt: IndexPath(item: 0, section: 1)) as? User1CollectionViewCell != nil else {
            XCTFail("Invalid cell type")
            return
        }
    }
}
