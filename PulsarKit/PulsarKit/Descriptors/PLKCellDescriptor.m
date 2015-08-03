//
//  PLKCellDescriptor.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCellDescriptor.h"

@implementation PLKCellDescriptor

+ (instancetype)cellDescriptorWithModel:(Class)model builder:(id<PLKCellBuilder>)builder strategy:(id<PLKSizeStrategy>)strategy {
    PLKCellDescriptor *cellDescriptor = [[self alloc] init];
    cellDescriptor.model = model;
    cellDescriptor.builder = builder;
    cellDescriptor.strategy = strategy;
    return cellDescriptor;
}

@end
