//
//  PLKCollectionViewCellBuilder.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/08/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCellBuilder.h"

@interface PLKCollectionViewCellBuilder : NSObject <PLKCellBuilder>

@property (nonatomic, readwrite, assign) Class cellClass;

+ (instancetype)builderWithCellClass:(Class)cellClass;

@end