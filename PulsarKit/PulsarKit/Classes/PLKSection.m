//
//  PLKSection.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/04/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKSection.h"

#import "PLKItem.h"

@interface PLKSection ()

@property (nonatomic, readwrite, strong) NSMutableArray *itemsInternal;
@property (nonatomic, readwrite, strong) NSMutableIndexSet *indexSet;

@end

@implementation PLKSection

#pragma mark - Helpers

- (void)updateIndexSetWithIndex:(NSInteger)index {
    [self.indexSet shiftIndexesStartingAtIndex:index by:1];
    [self.indexSet addIndex:index];
}

#pragma mark - Properties

- (NSMutableArray *)itemsInternal {
    if (!_itemsInternal) {
        _itemsInternal = [[NSMutableArray alloc] init];
    }
    
    return _itemsInternal;
}

- (NSMutableIndexSet *)indexSet {
    if (!_indexSet) {
        _indexSet = [[NSMutableIndexSet alloc] init];
    }
    
    return _indexSet;
}

- (NSArray *)items {
    return [self.itemsInternal copy];
}

#pragma mark - Indexes

- (NSIndexSet *)addedIndexes {
    NSIndexSet *indexSet = [self.indexSet copy];
    return indexSet;
}

- (void)resetIndexes {
    [self.indexSet removeAllIndexes];
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
    [self.indexSet shiftIndexesStartingAtIndex:self.itemsInternal.count by:items.count];
    [self.indexSet addIndexes:indexes];
    [self.itemsInternal addObjectsFromArray:items];
    return self;
}

#pragma mark - Models

- (PLKSection *)addModel:(id)model {
    return [self addModels:@[ model ]];
}

- (PLKSection *)addModels:(NSArray *)models {
    NSArray *items = [self createItemsFromModels:models];
    return [self addItems:items];
}

- (PLKSection *)addModelsOnTop:(NSArray *)models {
    NSArray *items = [self createItemsFromModels:models];
    [self.itemsInternal insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
    return self;
}

#pragma mark - Subscripting

- (PLKItem *)objectAtIndexedSubscript:(NSInteger)index {
    return self.items[index];
}

#pragma mark - Convenient Constructor

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