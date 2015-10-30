//
//  PLKSections.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class PLKItem;
@class PLKSection;

@interface PLKSections : NSObject

@property (nonatomic, readonly, copy) NSArray *models;
@property (nonatomic, readonly, assign) NSInteger count;
@property (nonatomic, readonly, assign) NSInteger itemsCount;
@property (nonatomic, readwrite, strong) PLKSection *topSection;
@property (nonatomic, readwrite, strong) PLKSection *bottomSection;

- (void)addItem:(PLKItem *)item;
- (void)addItems:(NSArray *)items;

- (void)addModel:(id)model;
- (void)addModels:(NSArray *)models;
- (void)addModelsOnTop:(NSArray *)models;
- (void)addModel:(id)model toSectionWithKey:(id)key;
- (void)addModels:(NSArray *)models toSectionWithKey:(id)key;

- (void)removeAll;
- (void)removeSection:(PLKSection *)section;
- (void)removeSections:(NSArray *)sections;

- (PLKSection *)addSection;
- (PLKSection *)addSectionWithKey:(id)key;
- (PLKSection *)addSectionAtIndex:(NSUInteger)position;
- (PLKSection *)objectAtIndexedSubscript:(NSUInteger)index;

- (NSIndexSet *)addedIndexes;
- (NSIndexSet *)removedIndexes;
- (NSArray *)addedIndexPaths;
- (NSArray *)removedIndexPaths;
- (void)resetIndexes;

@end
