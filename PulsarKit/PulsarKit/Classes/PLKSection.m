//
//  PLKSection.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/04/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKSection.h"

#import "PLKItem.h"
#import "PLKSectionDescriptor.h"

@interface PLKSection ()

@property (nonatomic, readwrite, strong) NSMutableArray *itemsInternal;
@property (nonatomic, readwrite, strong) NSMutableIndexSet *addedIndexSet;
@property (nonatomic, readwrite, strong) NSMutableIndexSet *removedIndexSet;

@end

@implementation PLKSection

#pragma mark - Helpers

- (void)updateIndexSetWithIndex:(NSInteger)index {
    [self.addedIndexSet shiftIndexesStartingAtIndex:index by:1];
    [self.addedIndexSet addIndex:index];
}

- (void)removeIndex:(NSInteger)index {
    if ([self.addedIndexSet containsIndex:index]) {
        [self.addedIndexSet shiftIndexesStartingAtIndex:0 by:-1];
    }
    else {
        [self.removedIndexSet addIndex:index];
    }
}

#pragma mark - Properties

- (NSArray *)models {
    return [self.items valueForKeyPath:@"@unionOfObjects.model"];
}

- (NSMutableArray *)itemsInternal {
    if (!_itemsInternal) {
        _itemsInternal = [[NSMutableArray alloc] init];
    }
    
    return _itemsInternal;
}

- (NSMutableIndexSet *)addedIndexSet {
    if (!_addedIndexSet) {
        _addedIndexSet = [[NSMutableIndexSet alloc] init];
    }
    
    return _addedIndexSet;
}

- (NSMutableIndexSet *)removedIndexSet {
    if (!_removedIndexSet) {
        _removedIndexSet = [[NSMutableIndexSet alloc] init];
    }
    
    return _removedIndexSet;
}

- (NSArray *)items {
    return [self.itemsInternal copy];
}

- (NSInteger)itemsCount {
    return self.itemsInternal.count;
}

#pragma mark - Indexes

- (NSIndexSet *)addedIndexes {
    NSIndexSet *indexSet = [self.addedIndexSet copy];
    return indexSet;
}

- (NSIndexSet *)removedIndexes {
    NSIndexSet *indexSet = [self.removedIndexSet copy];
    return indexSet;
}

- (void)resetIndexes {
    [self.addedIndexSet removeAllIndexes];
    [self.removedIndexSet removeAllIndexes];
}

#pragma mark - Items

- (NSArray *)createItemsFromModels:(NSArray *)models {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:models.count];
    
    for (id model in models) {
        [items addObject:[PLKItem itemWithModel:model]];
    }
    
    return [items copy];
}

- (PLKSection *)addItems:(NSArray *)items {
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.itemsInternal.count, items.count)];
    [self.addedIndexSet shiftIndexesStartingAtIndex:self.itemsInternal.count by:items.count];
    [self.addedIndexSet addIndexes:indexes];
    [self.itemsInternal addObjectsFromArray:items];
    return self;
}

#pragma mark - Models

- (NSInteger)indexOfItemForModel:(id)model {
    NSInteger index = [self.itemsInternal indexOfObjectPassingTest:^BOOL(PLKItem  * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        *stop = item.model == model;
        return *stop;
    }];
    
    return index;
}

- (PLKSection *)addModel:(id)model {
    return [self addModels:@[ model ]];
}

- (PLKSection *)addModels:(NSArray *)models {
    NSArray *items = [self createItemsFromModels:models];
    return [self addItems:items];
}

- (PLKSection *)addModelsOnTop:(NSArray *)models {
    NSArray *items = [self createItemsFromModels:models];
    
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)];
    [self.addedIndexSet shiftIndexesStartingAtIndex:0 by:models.count];
    [self.addedIndexSet addIndexes:indexes];
    [self.itemsInternal insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
    return self;
}

- (void)removeModel:(id)model {
    [self removeModels:@[ model ]];
}

- (void)removeModels:(NSArray *)models {
    for (id modelToRemove in models) {
        NSInteger index = [self indexOfItemForModel:modelToRemove];
        if (index != NSNotFound) {
            [self removeIndex:index];
            
        }
    }
    
    [self.itemsInternal removeObjectsAtIndexes:self.removedIndexes];
}

#pragma mark - Subscripting

- (PLKItem *)objectAtIndexedSubscript:(NSInteger)index {
    return self.items[index];
}

#pragma mark - Convenient Constructor

+ (instancetype)sectionWithSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor {
    PLKSection *section = [[self alloc] init];
    switch (sectionDescriptor.kind) {
        case PLKSectionKindHeader:
            section.headerDescription = sectionDescriptor;
            break;
            
        case PLKSectionKindFooter:
            section.footerDescription = sectionDescriptor;
    }
    
    return section;
}

+ (instancetype)sectionWithModels:(NSArray *)models {
    return [self sectionWithModels:models cellDescriptor:nil];
}

+ (instancetype)sectionWithModels:(NSArray *)models cellDescriptor:(id<PLKCellDescriptor>)cellDescriptor {
    PLKSection *section = [[self alloc] init];
    [section addModels:models];
    section.cellDescriptor = cellDescriptor;
    return section;
}

@end