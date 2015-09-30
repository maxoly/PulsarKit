//
//  PLKSections.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKSections.h"
#import "PLKSection.h"

// Categories
#import "NSArray+PulsarKit.h"

// Imports
@import UIKit;



// Extentions
@interface PLKSections ()

@property (nonatomic, readwrite, strong) NSMutableArray *sections;
@property (nonatomic, readwrite, strong) NSMutableIndexSet *indexSet;

@end



// Implementation
@implementation PLKSections

#pragma mark - Heplers

- (NSInteger)indexOfSectionWithKey:(id)key {
    return [self.sections indexOfObjectPassingTest:^BOOL(PLKSection *section, NSUInteger idx, BOOL *stop) {
        *stop = [section.key isEqual:key];
        return *stop;
    }];
}

- (void)updateIndexSetWithIndex:(NSInteger)index {
    [self.indexSet shiftIndexesStartingAtIndex:index by:1];
    [self.indexSet addIndex:index];
}

#pragma mark - Properties

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [[NSMutableArray alloc] init];
    }
    
    return _sections;
}

- (NSMutableIndexSet *)indexSet {
    if (!_indexSet) {
        _indexSet = [[NSMutableIndexSet alloc] init];
    }
    
    return _indexSet;
}

- (NSInteger)count {
    return self.sections.count;
}

- (NSInteger)itemsCount {
    NSNumber *sum = [self.sections valueForKeyPath:@"@sum.items.@count"];
    return [sum integerValue];
}

- (void)addModel:(id)model {
    [self addModels:@[ model ]];
}

- (void)addModelsOnTop:(NSArray *)models {
    PLKSection *section = [self returnOrCreateLastSection];
    [section addModelsOnTop:models];
}

- (void)addModels:(NSArray *)models {
    PLKSection *section = [self returnOrCreateLastSection];
    [section addModels:models];
    
}

- (void)addModel:(id)model toSectionWithKey:(id)key {
    [self addModels:@[ model ] toSectionWithKey:key];
}

- (void)addModels:(NSArray *)models toSectionWithKey:(id)key {
    PLKSection *section = [self returnOrCreateSectionWithKey:key];
    [section addModels:models];
}

#pragma mark - Sections

- (void)resetIndexes {
    [self.indexSet removeAllIndexes];
    for (PLKSection *section in self.sections) {
        [section resetIndexes];
    }
}
- (NSIndexSet *)addedIndexes {
    NSIndexSet *indexSet = [self.indexSet copy];
    return indexSet;
}

- (NSIndexPath *)addedIndexPaths {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (NSInteger sectionIndex = 0; sectionIndex < self.sections.count; sectionIndex++) {
        PLKSection *section = self.sections[sectionIndex];
        NSIndexSet *indexSet = section.addedIndexes;
        [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:sectionIndex]];
        }];
    }
    
    return [indexPaths copy];
}

- (PLKSection *)returnOrCreateLastSection {
    PLKSection *section = [self.sections lastObject];
    
    if (!section) {
        section = [self addSection];
    }
    
    return section;
}

- (PLKSection *)returnOrCreateSectionWithKey:(id)key {
    NSInteger index = [self indexOfSectionWithKey:key];
    if (index == NSNotFound) {
        PLKSection *section = [self addSection];
        section.key = key;
        return section;
    }
    
    return self.sections[index];
}

- (PLKSection *)addSection {
    return [self addSectionAtIndex:self.sections.count];
}

- (PLKSection *)addSectionWithKey:(id)key {
    return [self returnOrCreateSectionWithKey:key];
}

- (PLKSection *)addSectionAtIndex:(NSUInteger)index {
    PLKSection *section = [self.sections plk_safeObjectAtIndex:index];
    
    if (!section) {
        section = [[PLKSection alloc] init];
        [self.sections insertObject:section atIndex:index];
        [self updateIndexSetWithIndex:index];
    }
    
    return section;
}

#pragma mark - Items

- (void)addItem:(PLKItem *)item {
    [self addItems:@[ item ]];
}

- (void)addItems:(NSArray *)items {
    PLKSection *section = [self returnOrCreateLastSection];
    [section addItems:items];
}

#pragma mark - Subscripting

- (PLKSection *)objectAtIndexedSubscript:(NSUInteger)index {
    return self.sections[index];
}

@end