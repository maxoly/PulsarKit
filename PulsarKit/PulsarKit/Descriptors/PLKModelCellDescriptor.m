//
//  PLKModelCellDescriptor.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKModelCellDescriptor.h"

#import "PLKAutolayoutSize.h"

@implementation PLKModelCellDescriptor

#pragma mark - Convenient Constructor

+ (instancetype)descriptorWithCellClass:(Class)cellClass {
    return [self descriptorWithCellClass:cellClass forModelClass:[NSNull class]];
}

+ (instancetype)descriptorWithCellClass:(Class)cellClass forModelClass:(Class)modelClass {
    return [self descriptorWithCellClass:cellClass forModelClass:modelClass sizeStrategy:[PLKAutolayoutSize autolayoutSize]];
}

+ (instancetype)descriptorWithCellClass:(Class)cellClass forModelClass:(Class)modelClass sizeStrategy:(id<PLKSizeStrategy>)sizeStrategy {
    PLKModelCellDescriptor *cellDescriptor = [[self alloc] init];
    cellDescriptor.cellClass = cellClass;
    cellDescriptor.modelClass = modelClass;
    cellDescriptor.sizeStrategy = sizeStrategy;
    return cellDescriptor;
}

@end
