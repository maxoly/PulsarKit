//
//  CollectionSource+Sections.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

// MARK: - Add
public extension CollectionSource {
    @discardableResult
    func add(section: SourceSection) -> SourceSection {
        return sections.add(element: section)
    }
    
    @discardableResult
    func addSection() -> SourceSection {
        return sections.add()
    }
    
    @discardableResult
    func add<Model: Hashable>(header: Model) -> SourceSection {
        return sections.add(element: SourceSection(headerModel: header))
    }
}
