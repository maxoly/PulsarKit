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


@interface PLKSection : NSObject

@property (nonatomic, readonly, copy) NSArray *items;
@property (nonatomic, readwrite, strong) id<PLKCellDescriptor> cellDescriptor;

- (void)addItems:(NSArray *)items;
- (void)addModels:(NSArray *)models;
- (void)addModelsOnTop:(NSArray *)models;

- (PLKItem *)objectAtIndexedSubscript:(NSInteger)index;

+ (instancetype)sectionWithModels:(NSArray *)models;
+ (instancetype)sectionWithModels:(NSArray *)items cellDescriptor:(id<PLKCellDescriptor>)cellDescriptor;

@end
