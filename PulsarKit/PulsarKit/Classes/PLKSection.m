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

@end

@implementation PLKSection

#pragma mark - Properties

- (NSMutableArray *)itemsInternal {
    if (!_itemsInternal) {
        _itemsInternal = [[NSMutableArray alloc] init];
    }

    return _itemsInternal;
}

- (NSArray *)items {
    return [self.itemsInternal copy];
}

#pragma mark - Items

- (NSArray *)createItemsFromEntities:(NSArray *)entities {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:entities.count];

    for (id entity in entities) {
        [items addObject:[PLKItem itemWithEntity:entity]];
    }

    return [items copy];
}

- (void)addItems:(NSArray *)items {
    [self.itemsInternal addObjectsFromArray:items];
}

#pragma mark - Entities

- (void)addEntities:(NSArray *)entities {
    NSArray *items = [self createItemsFromEntities:entities];
    [self addItems:items];
}

- (void)addEntitiesOnTop:(NSArray *)entities {
    NSArray *items = [self createItemsFromEntities:entities];
    [self.itemsInternal insertObjects:items atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, items.count)]];
}

#pragma mark - Subscripting

- (PLKItem *)objectAtIndexedSubscript:(NSInteger)index {
    return self.items[index];
}

@end
