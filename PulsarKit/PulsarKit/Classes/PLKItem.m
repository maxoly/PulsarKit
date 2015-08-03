//
//  PLKItem.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKItem.h"

@implementation PLKItem

+ (instancetype)itemWithEntity:(id)entity {
    PLKItem *item = [[self alloc] init];
    item.entity = entity;
    return item;
}

@end
