//
//  SourceSection.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import Foundation

public final class SourceSection {
    public var headerModel: AnyHashable?
    public var footerModel: AnyHashable?
    public var layout: Layout?
    public var itemsSize: Sizeable?
    
    public lazy var models = SourceDiff<AnyHashable>()
    
    public init(headerModel: AnyHashable? = nil, footerModel: AnyHashable? = nil, layout: Layout? = nil, itemsSize: Sizeable? = nil) {
        self.layout = layout
        self.itemsSize = itemsSize
        self.headerModel = headerModel
        self.footerModel = footerModel
    }
}

// MARK: - Public methods
public extension SourceSection {
    var modelsCount: Int {
        models.staged.count
    }
    
    func currentOf<T>(type: T.Type) -> [T] {
        models.currentOf(type: type)
    }
    
    func stagedOf<T>(type: T.Type) -> [T] {
        models.stagedOf(type: type)
    }
}

// MARK: - Nested types
public extension SourceSection {
    struct Layout {
        public let inset: UIEdgeInsets
        public let minimumLineSpacing: CGFloat
        public let minimumInteritemSpacing: CGFloat
        
        public static let zero = Layout()
        
        public init(inset: UIEdgeInsets = .zero, minimumLineSpacing: CGFloat = 0, minimumInteritemSpacing: CGFloat = 0) {
            self.inset = inset
            self.minimumLineSpacing = minimumLineSpacing
            self.minimumInteritemSpacing = minimumInteritemSpacing
        }
    }
}

// MARK: - Hashable
extension SourceSection: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

// MARK: - Equatable
extension SourceSection: Equatable {
    public static func == (lhs: SourceSection, rhs: SourceSection) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
