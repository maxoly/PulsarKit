//
//  PLKTableCellDescriptor.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKTableCellDescriptor.h"

#import "PLKFixedSize.h"
#import "PLKAutolayoutSize.h"
#import "PLKTableCellBuilder.h"

@implementation PLKTableCellDescriptor

+ (instancetype)cellDescriptorWithCellClass:(Class)cellClass forModel:(Class)model {
    return [self cellDescriptorWithModel:model
                                 builder:[PLKTableCellBuilder builderWithCellClass:cellClass]
                                strategy:[PLKFixedSize fixedSize:CGSizeMake(0, 44.0f)]];
}

+ (instancetype)cellDescriptorWithCellClass:(Class)cellClass forModel:(Class)model sizeStrategy:(id<PLKSizeStrategy>)strategy {
    return [self cellDescriptorWithModel:model
                                 builder:[PLKTableCellBuilder builderWithCellClass:cellClass]
                                strategy:strategy];
}

@end
