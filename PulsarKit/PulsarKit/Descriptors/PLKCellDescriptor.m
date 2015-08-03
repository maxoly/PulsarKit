//
//  PLKCellDescriptor.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCellDescriptor.h"

#import "PLKFixedSize.h"
#import "PLKAutolayoutSize.h"
#import "PLKTableCellBuilder.h"
#import "PLKCollectionViewCellBuilder.h"

CGFloat const PLKDefaultCellSize = 44.0f;

@implementation PLKCellDescriptor

+ (instancetype)cellDescriptorWithModel:(Class)model builder:(id<PLKCellBuilder>)builder strategy:(id<PLKSizeStrategy>)strategy {
    PLKCellDescriptor *cellDescriptor = [[self alloc] init];
    cellDescriptor.model = model;
    cellDescriptor.builder = builder;
    cellDescriptor.strategy = strategy;
    return cellDescriptor;
}

+ (instancetype)collectionCellDescriptorWithCellClass:(Class)cellClass forModel:(Class)model {
    return [self cellDescriptorWithModel:model
                                 builder:[PLKCollectionViewCellBuilder builderWithCellClass:cellClass]
                                strategy:[PLKFixedSize fixedSize:CGSizeMake(0, PLKDefaultCellSize)]];
}

+ (instancetype)collectionCellDescriptorWithDynamicCellClass:(Class)cellClass forModel:(Class)model {
    return [self cellDescriptorWithModel:model
                                 builder:[PLKCollectionViewCellBuilder builderWithCellClass:cellClass]
                                strategy:[[PLKAutolayoutSize alloc] init]];
}

+ (instancetype)tableCellDescriptorWithCellClass:(Class)cellClass forModel:(Class)model {
    return [self cellDescriptorWithModel:model
                                 builder:[PLKTableCellBuilder builderWithCellClass:cellClass]
                                strategy:[PLKFixedSize fixedSize:CGSizeMake(0, PLKDefaultCellSize)]];
}

+ (instancetype)tableCellDescriptorWithDynamicCellClass:(Class)cellClass forModel:(Class)model {
    return [self cellDescriptorWithModel:model
                                 builder:[PLKTableCellBuilder builderWithCellClass:cellClass]
                                strategy:[[PLKAutolayoutSize alloc] init]];
}

@end
