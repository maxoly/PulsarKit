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
@property (nonatomic, readwrite, strong) NSMutableIndexSet *addedIndexSet;
@property (nonatomic, readwrite, strong) NSMutableIndexSet *removedIndexSet;

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

#pragma mark - Properties

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [[NSMutableArray alloc] init];
    }
    
    return _sections;
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

- (NSInteger)count {
    return self.sections.count + (self.topSection ? 1 : 0) + (self.bottomSection ? 1 : 0);
}

- (NSInteger)itemsCount {
    NSNumber *sum = [self.sections valueForKeyPath:@"@sum.items.@count"];
    return [sum integerValue];
}

- (void)setTopSection:(PLKSection *)topSection {
    if (!_topSection) {
        [self updateIndexSetWithIndex:0];
    }
    
    if (!topSection && _topSection) {
        [self removeIndex:0];
    }
    
    _topSection = topSection;
}

- (void)setBottomSection:(PLKSection *)bottomSection {
    if (!_bottomSection && bottomSection) {
        [self updateIndexSetWithIndex:self.count];
    }
    
    if (!bottomSection && _bottomSection) {
        [self removeIndex:self.count-1];
    }
    
    _bottomSection = bottomSection;
}

#pragma mark - Model

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

#pragma mark - Indexes

- (void)resetIndexes {
    [self.addedIndexSet removeAllIndexes];
    [self.removedIndexSet removeAllIndexes];
    
    for (PLKSection *section in self.sections) {
        [section resetIndexes];
    }
}

- (NSIndexSet *)removedIndexes {
    return [self.removedIndexSet copy];
}

- (NSIndexSet *)addedIndexes {
    return [self.addedIndexSet copy];
}

- (NSIndexPath *)addedIndexPaths {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (NSInteger sectionIndex = 0; sectionIndex < self.count; sectionIndex++) {
        PLKSection *section = self[sectionIndex];
        NSIndexSet *indexSet = section.addedIndexes;
        [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:sectionIndex]];
        }];
    }
    
    return [indexPaths copy];
}

- (NSIndexPath *)removedIndexPaths {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (NSInteger sectionIndex = 0; sectionIndex < self.count; sectionIndex++) {
        PLKSection *section = self[sectionIndex];
        NSIndexSet *indexSet = section.removedIndexes;
        [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:sectionIndex]];
        }];
    }
    
    return [indexPaths copy];
}

#pragma mark - Section

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

#pragma mark - Removing

- (void)removeAll {
    [self removeSections:self.sections.copy];
}

- (void)removeSection:(PLKSection *)section {
    [self removeSections:@[ section ]];
}

- (void)removeSections:(NSArray *)sections {
    for (PLKSection *sectionToRemove in sections) {
        NSInteger index = [self.sections indexOfObject:sectionToRemove];
        [self removeIndex:index];
    }
    
    [self.sections removeObjectsInArray:sections];
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
    if (self.topSection && index == 0) {
        return self.topSection;
    }
    
    if (index >= self.sections.count) {
        return self.bottomSection;
    }
    
    return [self.sections plk_safeObjectAtIndex:index];
}

@end