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

- (NSArray *)createItemsFromModels:(NSArray *)models {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:models.count];

    for (id model in models) {
        [items addObject:[PLKItem itemWithModel:model]];
    }

    return [items copy];
}

- (PLKSection *)addItems:(NSArray *)items {
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
