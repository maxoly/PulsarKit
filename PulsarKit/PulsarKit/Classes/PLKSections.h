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

@property (nonatomic, readonly, assign) NSInteger count;
@property (nonatomic, readonly, assign) NSInteger itemsCount;

- (void)addItem:(PLKItem *)item;
- (void)addItems:(NSArray *)items;

- (void)addModel:(id)model;
- (void)addModels:(NSArray *)models;
- (void)addModelsOnTop:(NSArray *)models;
- (void)addModel:(id)model toSectionWithKey:(id)key;
- (void)addModels:(NSArray *)models toSectionWithKey:(id)key;

- (PLKSection *)addSection;
- (PLKSection *)addSectionWithKey:(id)key;
- (PLKSection *)addSectionAtIndex:(NSUInteger)position;
- (PLKSection *)objectAtIndexedSubscript:(NSUInteger)index;

@end
