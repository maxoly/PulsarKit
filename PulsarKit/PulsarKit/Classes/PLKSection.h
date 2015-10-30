//
//  PLKSection.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/04/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class PLKItem;

@protocol PLKCellDescriptor;
@protocol PLKSectionDescriptor;



@interface PLKSection : NSObject

@property (nonatomic, readonly, copy) NSArray *items;
@property (nonatomic, readonly, copy) NSArray *models;

@property (nonatomic, readwrite, strong) id key;
@property (nonatomic, readwrite, strong) id model;
@property (nonatomic, readwrite, assign, getter=isSpecial) BOOL special;
@property (nonatomic, readwrite, strong) id<PLKCellDescriptor> cellDescriptor;
@property (nonatomic, readwrite, strong) id<PLKSectionDescriptor> headerDescription;
@property (nonatomic, readwrite, strong) id<PLKSectionDescriptor> footerDescription;

- (PLKSection *)addItems:(NSArray *)items;
- (PLKSection *)addModel:(id)model;
- (PLKSection *)addModels:(NSArray *)models;
- (PLKSection *)addModelsOnTop:(NSArray *)models;

- (void)removeModel:(id)model;
- (void)removeModels:(NSArray *)models;

- (PLKItem *)objectAtIndexedSubscript:(NSInteger)index;

+ (instancetype)sectionWithSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor;
+ (instancetype)sectionWithModels:(NSArray *)models;
+ (instancetype)sectionWithModels:(NSArray *)items cellDescriptor:(id<PLKCellDescriptor>)cellDescriptor;


- (NSIndexSet *)addedIndexes;
- (NSIndexSet *)removedIndexes;
- (void)resetIndexes;

@end
