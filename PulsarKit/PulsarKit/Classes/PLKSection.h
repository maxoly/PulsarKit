//
//  PLKSection.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/04/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class PLKItem;

@class PLKCellDescriptor;



@interface PLKSection : NSObject

@property (nonatomic, readonly, copy) NSArray *items;
@property (nonatomic, readwrite, strong) PLKCellDescriptor *descriptor;

- (void)addItems:(NSArray *)items;
- (void)addEntities:(NSArray *)entities;
- (void)addEntitiesOnTop:(NSArray *)entities;

- (PLKItem *)objectAtIndexedSubscript:(NSInteger)index;

@end
