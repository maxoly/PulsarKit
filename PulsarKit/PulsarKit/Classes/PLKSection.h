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
@property (nonatomic, readwrite, strong) id key;
@property (nonatomic, readwrite, strong) id model;
@property (nonatomic, readwrite, strong) id<PLKCellDescriptor> cellDescriptor;
@property (nonatomic, readwrite, strong) id<PLKSectionDescriptor> sectionDescriptor;

- (PLKSection *)addItems:(NSArray *)items;
- (PLKSection *)addModel:(id)model;
- (PLKSection *)addModels:(NSArray *)models;
- (PLKSection *)addModelsOnTop:(NSArray *)models;

- (PLKItem *)objectAtIndexedSubscript:(NSInteger)index;

+ (instancetype)sectionWithModels:(NSArray *)models;
+ (instancetype)sectionWithModels:(NSArray *)items cellDescriptor:(id<PLKCellDescriptor>)cellDescriptor;


- (NSIndexSet *)addedIndexes;
- (void)resetIndexes;

@end
