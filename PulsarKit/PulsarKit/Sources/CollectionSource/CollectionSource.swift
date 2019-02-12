//
//  CollectionSource.swift
//  PulsarKit
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

public final class CollectionSource: NSObject, Source {
    public private(set) var container: UICollectionView
    public private(set) lazy var plugins = [SourcePlugin]()
    public private(set) lazy var sections = SourceDiff<SourceSection>()
    public private(set) lazy var on = CollectionEvents<AnyHashable, UICollectionViewCell>()
    
    internal var isFirstTime: Bool = true
    internal lazy var filters = [SourcePluginFilter]()
    internal lazy var descriptors = [String: Descriptor]()
    internal lazy var registeredIdentifiers = Set<String>()
    internal lazy var cellCache: NSCache<NSString, UIView> = NSCache<NSString, UIView>()
    internal lazy var sizeCache: NSCache<NSString, NSValue> = NSCache<NSString, NSValue>()
    
    public init(container: UICollectionView = .standard) {
        self.container = container
        super.init()
        self.setup()
    }
    
    deinit {
        plugins.forEach { $0.deactivate() }
    }
}

internal extension CollectionSource {
    func modelType<Model>(of model: Model) -> Any.Type {
        if (model is AnyHashable) == false {
            return type(of: model)
        }
        
        guard let hashable = model as? AnyHashable else {
            return type(of: model)
        }
        
        let boxType = type(of: hashable.base)
        if boxType is AnyHashable.Type {
            return modelType(of: hashable.base)
        }
        
        return boxType
    }
    
    func cell<C: UIView>(for descriptor: Descriptor) -> C? {
        let key = String(describing: descriptor.cellType)
        if let cell = cellCache.object(forKey: key as NSString) {
            return cell as? C
        }
        
        let result = descriptor.create() as? C
        if let cell = result {
            cellCache.setObject(cell, forKey: key as NSString)
        }
        return result
    }
    
    func registerCell(from descriptor: Descriptor) {
        if descriptor.isCellAlreadyRegistered { return }
        registerCell(cellIdentifier: descriptor.cellReuseIdentifier, descriptor: descriptor)
    }
        
    func registerCell(cellIdentifier: String, descriptor: Descriptor) {
        guard !registeredIdentifiers.contains(cellIdentifier) else { return }
            
        let bundle = Bundle(for: descriptor.cellClass)
        let nibName = String(describing: descriptor.cellClass)
        let nibUrl = bundle.path(forResource: nibName, ofType: "nib")
        
        if nibUrl != nil {
            let nib = UINib(nibName: nibName, bundle: bundle)
            
            if descriptor.cellClass.isSubclass(of: UICollectionViewCell.self) {
                container.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            } else {
                container.register(nib,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: cellIdentifier)
                container.register(nib,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                   withReuseIdentifier: cellIdentifier)
            }
        } else {
            if descriptor.cellClass.isSubclass(of: UICollectionViewCell.self) {
                container.register(descriptor.cellClass, forCellWithReuseIdentifier: cellIdentifier)
            } else {
                container.register(descriptor.cellClass,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: cellIdentifier)
                container.register(descriptor.cellClass,
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                   withReuseIdentifier: cellIdentifier)
            }
        }
        
        registeredIdentifiers.insert(cellIdentifier)
    }
}

// MARK: - Private
private extension CollectionSource {
    func setup() {
        container.dataSource = self
        container.delegate = self
        container.keyboardDismissMode = .onDrag
        container.alwaysBounceVertical = true
        container.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
    }
    
    func batchUpdate() {
        isFirstTime = false
        let changeSet = sections.commit()
        
        // Performs reload
        container.reloadSections(changeSet.reloaded)
        
        // Performs delete
        container.deleteSections(changeSet.deleted)
        
        // Performs insert
        container.insertSections(changeSet.inserted)
        
        // Performs move
        changeSet.moved.forEach { container.moveSection($0.from, toSection: $0.to) }
     
        // Now it's time for section's models
        sections.current.enumerated().forEach { entry in
            let actualSectionIndex = entry.offset
            let previousSectionIndex = changeSet.remapped[entry.offset] ?? actualSectionIndex
            
            let section = entry.element
            let sectionChangeSet = section.models.commit()
            
            // reload
            let reloadedIndexPaths = sectionChangeSet.reloaded.map { IndexPath(item: $0, section: previousSectionIndex) }
            self.container.reloadItems(at: reloadedIndexPaths)
            
            // deleted
            let deletedIndexPaths = sectionChangeSet.deleted.map { IndexPath(item: $0, section: previousSectionIndex) }
            self.container.deleteItems(at: deletedIndexPaths)
            
            // inserted
            let insertedIndexPaths = sectionChangeSet.inserted.map { IndexPath(item: $0, section: actualSectionIndex) }
            self.container.insertItems(at: insertedIndexPaths)
            
            // moved
            sectionChangeSet.moved.forEach { entry in
                let toSection = entry.toSection ?? previousSectionIndex
                let fromIndexPath = IndexPath(item: entry.from, section: previousSectionIndex)
                let toIndexPath = IndexPath(item: entry.to, section: toSection)
                self.container.moveItem(at: fromIndexPath, to: toIndexPath)
            }
        }
    }
}

// MARK: - Updating
public extension CollectionSource {
    func update(forceReload: Bool = false, completion: ((Bool) -> Void)? = nil) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async {
                self.update(forceReload: forceReload, completion: completion)
            }
            
            return
        }
        
        if forceReload {
            sizeCache.removeAllObjects()
            container.reloadData()
            sections.commit()
            sections.current.forEach { $0.models.commit() }
            isFirstTime = false
            return
        }
        
        container.performBatchUpdates({
            self.batchUpdate()
        }, completion: completion)
    }
}

// MARK: - Handlers
public extension CollectionSource {
    func add(plugin: SourcePlugin) {
        plugins.append(plugin)
        plugin.activate()
        
        if let filter = plugin.filter {
            filters.append(filter)
        }
    }
}

// MARK: - Descriptors
public extension CollectionSource {
    func configuration<Model: Hashable, Cell: UIView>(for modelType: Model.Type, cell: Cell.Type) -> DescriptorConfiguration<Model, Cell>? {
        let key = String(describing: modelType)
        let descriptor = descriptors[key]
        return descriptor?.cellConfiguration() as? DescriptorConfiguration<Model, Cell>
    }
    
    func descriptor<Model>(for modelType: Model.Type) -> Descriptor? {
        let key = String(describing: modelType)
        return descriptors[key]
    }
    
    func descriptor(for model: AnyHashable) -> Descriptor? {
        return descriptors[String(describing: modelType(of: model))]
    }
    
    @discardableResult
    func add(descriptor: Descriptor) -> Descriptor {
        let key = String(describing: descriptor.modelType)
        descriptors[key] = descriptor
        registerCell(from: descriptor)
        return descriptor
    }
    
    func remove(descriptor: Descriptor) {
        let key = String(describing: descriptor.modelType)
        descriptors.removeValue(forKey: key)
    }
    
    func removeDescriptor<Model: Hashable>(for modelType: Model.Type) {
        let key = String(describing: modelType)
        descriptors.removeValue(forKey: key)
    }
    
    func when<Model: Hashable>(_ type: Model.Type) -> DescriptorBuilder<Model> {
        let descriptorFactory = DescriptorBuilder<Model> { [weak self] descriptor in
            self?.add(descriptor: descriptor)
        }
        
        return descriptorFactory
    }
}
