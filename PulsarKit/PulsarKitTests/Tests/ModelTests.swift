//
//  ModelTests.swift
//  PulsarKitTests
//
//  Created by Massimo Oliviero on 11/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import XCTest
@testable import PulsarKit

// swiftlint:disable file_length
// swiftlint:disable type_body_length
class ModelTests: XCTestCase {
    func testIndexPaths() {
        // Arrange
        let source = CollectionSource()
        
        // Act
        let section1 = source.sections.add()
        for index in 1..<40 { section1.models.add(element: User(id: index)) }
        
        let section2 = source.sections.add()
        for index in 40..<60 { section2.models.add(element: User(id: index)) }
        section2.models.add(element: User(id: 30))
        
        let section3 = source.sections.add()
        for index in 60..<100 { section3.models.add(element: User(id: index)) }
        section3.models.add(element: User(id: 30))

        source.update()
        let result = source.indexPaths(of: User(id: 30))
        
        // Assert
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(source.sections.count, 3)

    }
    
    func testAddModels() {
        // Arrange
        let source = CollectionSource()
        let random = Int.random(in: 1...100)
        
        // Act
        let section = source.sections.add()
        for _ in 1...random {
            section.models.add(element: User(id: 1))
        }
        
        source.update()
        
        // Assert
        XCTAssertEqual(source.models.count, random)
        XCTAssertEqual(source.sections.count, 1)
    }
    
    func testAddModelsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        section.models.add(element: User(id: 1))
        section.models.add(element: User(id: 2))
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        section.models.add(element: User(id: 3))
        section.models.add(element: User(id: 4))
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 4)
        XCTAssertEqual(source.sections.count, 1)
    }
    
    func testInsertModels() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        section.models.add(element: User(id: 1))
        section.models.add(element: User(id: 2))
        section.models.add(element: User(id: 3))
        section.models.add(element: User(id: 4))
        source.update()
        
        // Act
        let model1 = User(id: 5)
        let model3 = User(id: 6)
        section.models.insert(element: model3, at: 3)
        section.models.insert(element: model1, at: 1)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.models.count, 6)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[1].hashValue == model1.hashValue)
        XCTAssert(section.models[3].hashValue == model3.hashValue)
    }
    
    func testInsertModelsInRange() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        section.models.add(element: User(id: 1))
        section.models.add(element: User(id: 2))
        section.models.add(element: User(id: 3))
        section.models.add(element: User(id: 4))
        source.update()
        
        // Act
        let model1 = User(id: 5)
        let model2 = User(id: 6)
        section.models.insert(elements: [model1, model2], in: 1...2)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.models.count, 6)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[1].hashValue == model1.hashValue)
        XCTAssert(section.models[2].hashValue == model2.hashValue)
    }
    
    func testInsertModelsInRangeBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        section.models.add(element: User(id: 1))
        section.models.add(element: User(id: 2))
        section.models.add(element: User(id: 3))
        section.models.add(element: User(id: 4))
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        let model1 = User(id: 5)
        let model2 = User(id: 6)
        section.models.insert(elements: [model1, model2], in: 1...2)
        source.update { _ in exp.fulfill() }
        
        // Assert
        waitForExpectations(timeout: 5)
        XCTAssertEqual(source.models.count, 6)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[1].hashValue == model1.hashValue)
        XCTAssert(section.models[2].hashValue == model2.hashValue)
    }
    
    func testInsertModelsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        section.models.add(element: User(id: 1))
        section.models.add(element: User(id: 2))
        section.models.add(element: User(id: 3))
        section.models.add(element: User(id: 4))
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        let model1 = User(id: 5)
        let model3 = User(id: 6)
        section.models.insert(element: model3, at: 3)
        section.models.insert(element: model1, at: 1)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 6)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[1].hashValue == model1.hashValue)
        XCTAssert(section.models[3].hashValue == model3.hashValue)
    }
    
    func testDeleteModels() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section.models.add(element: model1)
        section.models.add(element: model2)
        section.models.add(element: model3)
        section.models.add(element: model4)
        source.update()
        
        // Act
        section.models.delete(at: 3)
        section.models.delete(at: 1)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.models.count, 2)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[0].hashValue == model1.hashValue)
        XCTAssert(section.models[1].hashValue == model3.hashValue)
    }
    
    func testDeleteModelsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section.models.add(element: model1)
        section.models.add(element: model2)
        section.models.add(element: model3)
        section.models.add(element: model4)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        section.models.delete(at: 3)
        section.models.delete(at: 1)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 2)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[0].hashValue == model1.hashValue)
        XCTAssert(section.models[1].hashValue == model3.hashValue)
    }
    
    func testMoveModels() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section.models.add(element: model1)
        section.models.add(element: model2)
        section.models.add(element: model3)
        section.models.add(element: model4)
        source.update()
        
        // Act
        section.models.move(from: 0, to: 3)
        source.update(forceReload: true)
        
        // Assert
        XCTAssertEqual(source.models.count, 4)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[0].hashValue == model2.hashValue)
        XCTAssert(section.models[1].hashValue == model3.hashValue)
        XCTAssert(section.models[2].hashValue == model4.hashValue)
        XCTAssert(section.models[3].hashValue == model1.hashValue)
    }
    
    func testMoveModelsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section.models.add(element: model1)
        section.models.add(element: model2)
        section.models.add(element: model3)
        section.models.add(element: model4)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        section.models.move(from: 0, to: 3)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 4)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[0].hashValue == model2.hashValue)
        XCTAssert(section.models[1].hashValue == model3.hashValue)
        XCTAssert(section.models[2].hashValue == model4.hashValue)
        XCTAssert(section.models[3].hashValue == model1.hashValue)
    }
    
    func testMoveModelsAndSectionsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section1 = source.sections.add()
        let section2 = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section1.models.add(element: model1)
        section1.models.add(element: model2)
        section2.models.add(element: model3)
        section2.models.add(element: model4)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        source.sections.move(from: 0, to: 1)
        section1.models.move(from: 0, to: 1)
        section2.models.move(from: 0, to: 1)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 4)
        XCTAssertEqual(source.sections.count, 2)
        XCTAssert(source.sections[0] === section2)
        XCTAssert(source.sections[1] === section1)
        XCTAssert(section1.models[0].hashValue == model2.hashValue)
        XCTAssert(section1.models[1].hashValue == model1.hashValue)
        XCTAssert(section2.models[0].hashValue == model4.hashValue)
        XCTAssert(section2.models[1].hashValue == model3.hashValue)
    }
    
    func testReloadModels() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        let user1 = User(id: 1)
        let user2 = User(id: 2)
        section.models.add(element: user1)
        section.models.add(element: user2)
        section.models.add(element: user1)
        section.models.add(element: user2)
        source.update()
        
        // Act
        let newmodel = User(id: 1, name: "new name")
        section.models.reload(element: newmodel)
        source.update()
        
        // Assert
        guard let model0 = section.models[0] as? User else { XCTFail("Invalid model"); return }
        guard let model1 = section.models[1] as? User else { XCTFail("Invalid model"); return }
        guard let model2 = section.models[2] as? User else { XCTFail("Invalid model"); return }
        guard let model3 = section.models[3] as? User else { XCTFail("Invalid model"); return }
        
        XCTAssertEqual(source.models.count, 4)
        XCTAssertEqual(model0.name, newmodel.name)
        XCTAssertEqual(model1.name, "")
        XCTAssertEqual(model2.name, newmodel.name)
        XCTAssertEqual(model3.name, "")
    }
    
    func testReloadModelsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        let user1 = User(id: 1)
        let user2 = User(id: 2)
        section.models.add(element: user1)
        section.models.add(element: user2)
        section.models.add(element: user1)
        section.models.add(element: user2)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        let newmodel = User(id: 1, name: "new name")
        section.models.reload(element: newmodel)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        guard let model0 = section.models[0] as? User else { XCTFail("Invalid model"); return }
        guard let model1 = section.models[1] as? User else { XCTFail("Invalid model"); return }
        guard let model2 = section.models[2] as? User else { XCTFail("Invalid model"); return }
        guard let model3 = section.models[3] as? User else { XCTFail("Invalid model"); return }
        
        XCTAssertEqual(source.models.count, 4)
        XCTAssertEqual(model0.name, newmodel.name)
        XCTAssertEqual(model1.name, "")
        XCTAssertEqual(model2.name, newmodel.name)
        XCTAssertEqual(model3.name, "")
    }
    
    func testAllModelsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        let section = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section.models.add(element: model1)
        section.models.add(element: model2)
        section.models.add(element: model3)
        section.models.add(element: model4)
        source.update()
        
        // Act
        let model5 = User(id: 5)
        let model6 = User(id: 6)
        let model7 = User(id: 7)
        let model8 = User(id: 8)
        let exp = expectation(description: "batch")
        section.models.delete(at: 0)
        section.models.delete(at: 1)
        section.models.delete(at: 2)
        section.models.insert(element: model6, at: 2)
        section.models.insert(element: model5, at: 0)
        section.models.add(element: model7)
        section.models.add(element: model8)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 5)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(section.models[0].hashValue == model5.hashValue)
        XCTAssert(section.models[1].hashValue == model4.hashValue)
        XCTAssert(section.models[2].hashValue == model6.hashValue)
        XCTAssert(section.models[3].hashValue == model7.hashValue)
        XCTAssert(section.models[4].hashValue == model8.hashValue)
    }
    
    func testSectionsAndModelsBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        source.sections.add()
        source.sections.add()
        
        // section 2
        let section2 = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section2.models.add(element: model1)
        section2.models.add(element: model2)
        section2.models.add(element: model3)
        section2.models.add(element: model4)
        
        // section 3
        let section3 = source.sections.add()
        let model5 = User(id: 5)
        let model6 = User(id: 6)
        let model7 = User(id: 7)
        let model8 = User(id: 8)
        section3.models.add(element: model5)
        section3.models.add(element: model6)
        section3.models.add(element: model7)
        section3.models.add(element: model8)
        source.update()
        
        // Act
        let model9 = User(id: 9)
        let model10 = User(id: 10)
        let exp = expectation(description: "batch")
        source.sections.delete(at: 0)
        source.sections.delete(at: 1)
        source.sections.delete(at: 2)
        section3.models.delete(at: 0)
        section3.models.add(element: model9)
        section3.models.insert(element: model10, at: 2)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 5)
        XCTAssertEqual(source.sections.count, 1)
        XCTAssert(source.models[0].hashValue == model6.hashValue)
        XCTAssert(source.models[1].hashValue == model7.hashValue)
        XCTAssert(source.models[2].hashValue == model10.hashValue)
        XCTAssert(source.models[3].hashValue == model8.hashValue)
        XCTAssert(source.models[4].hashValue == model9.hashValue)
    }
    
    func testSectionsAndModelsDeleteAllBatchUpdate() {
        // Arrange
        let source = CollectionSource()
        source.sections.add()
        source.sections.add()
        
        // section 2
        let section2 = source.sections.add()
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        section2.models.add(element: model1)
        section2.models.add(element: model2)
        section2.models.add(element: model3)
        section2.models.add(element: model4)
        
        // section 3
        let section3 = source.sections.add()
        let model5 = User(id: 5)
        let model6 = User(id: 6)
        let model7 = User(id: 7)
        let model8 = User(id: 8)
        section3.models.add(element: model5)
        section3.models.add(element: model6)
        section3.models.add(element: model7)
        section3.models.add(element: model8)
        source.update()
        
        // Act
        let model9 = User(id: 9)
        let model10 = User(id: 10)
        let exp = expectation(description: "batch")
        source.sections.deleteAll()
        let section4 = source.sections.add()
        section4.models.add(element: model9)
        section4.models.insert(element: model10, at: 0)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 2)
        XCTAssertEqual(source.sections.count, 1)
    }
    
    func testReloadAllModels() {
        // Arrange
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        
        let source = CollectionSource()
        let section0 = source.sections.add()
        let section1 = source.sections.add()
        
        section0.models.add(element: model1)
        section1.models.add(element: model2)
        section1.models.add(element: model3)
        section1.models.add(element: model1)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        let newModel1 = User(id: 1, name: "new")
        source.reload(allInstancesOf: newModel1)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 4)
        XCTAssertEqual(source.sections.count, 2)
        
        guard let model0s = source.models[0] as? User else { XCTFail("Invalid model"); return }
        guard let model3s = source.models[3] as? User else { XCTFail("Invalid model"); return }

        XCTAssertEqual(model0s.name, newModel1.name)
        XCTAssertEqual(model3s.name, newModel1.name)
    }
    
    func testRealodModelsInRange() {
        // Arrange
        let model1 = User(id: 1)
        let model2 = User(id: 2)
        let model3 = User(id: 3)
        let model4 = User(id: 4)
        
        let source = CollectionSource()
        let section0 = source.sections.add()
        
        section0.models.add(element: model1)
        section0.models.add(element: model2)
        section0.models.add(element: model3)
        section0.models.add(element: model4)
        source.update()
        
        // Act
        let exp = expectation(description: "batch")
        section0.models.reload(in: 2...3)
        source.update { _ in exp.fulfill() }
        
        // Assert
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(source.models.count, 4)
    }
}
