//
//  PLKItem.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKItem.h"

@implementation PLKItem

+ (instancetype)itemWithModel:(id)model {
    return [self itemWithModel:model cellDescriptor:nil];
}

+ (instancetype)itemWithModel:(id)model cellDescriptor:(id<PLKCellDescriptor>)cellDescriptor {
    PLKItem *item = [[self alloc] init];
    item.model = model;
    item.cellDescriptor = cellDescriptor;
    return item;
}

@end
