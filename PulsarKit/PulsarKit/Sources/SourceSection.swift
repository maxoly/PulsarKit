//
//  SourceSection.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import Foundation

public final class SourceSection {
    public struct Layout {
        public let inset: UIEdgeInsets = .zero
        public let minimumLineSpacing: CGFloat = 0
        public let minimumInteritemSpacing: CGFloat = 0
    }
    
    public var headerModel: AnyHashable?
    public var footerModel: AnyHashable?
    public var layout: Layout?
    
    public lazy var models = SourceDiff<AnyHashable>()
    
    public init(headerModel: AnyHashable? = nil, footerModel: AnyHashable? = nil, layout: Layout? = nil) {
        self.layout = layout
        self.headerModel = headerModel
        self.footerModel = footerModel
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
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}
