//
//  PLKDynamicCellDescriptorMatcher.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/09/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKDynamicCellDescriptorMatcher.h"

@implementation PLKDynamicCellDescriptorMatcher

+ (instancetype)matcherWithCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor keyPath:(NSString *)keyPath value:(id)value{
    PLKDynamicCellDescriptorMatcher *matcher = [[self alloc] init];
    matcher.cellDescriptor = cellDescriptor;
    matcher.keyPath = keyPath;
    matcher.value = value;
    return matcher;
}

@end
