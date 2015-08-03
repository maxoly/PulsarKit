//
//  PLKSections.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class PLKSection;

@interface PLKSections : NSObject <NSXMLParserDelegate>

@property (nonatomic, readonly, assign) NSInteger count;
@property (nonatomic, readonly, assign) NSInteger itemsCount;


- (void)addEntities:(NSArray *)entities;
- (void)addEntitiesOnTop:(NSArray *)entities;

- (PLKSection *)addSection;
- (PLKSection *)addSectionAtPostion:(NSInteger)position;
- (PLKSection *)objectAtIndexedSubscript:(NSInteger)index;

@end
