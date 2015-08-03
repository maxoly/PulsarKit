//
//  NSArray+PulsarKit.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/04/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "NSArray+PulsarKit.h"

@implementation NSArray (PulsarKit)

- (id)plk_safeObjectAtIndex:(NSInteger)index {
    if (index >= self.count) {
        return nil;
    }

    return [self objectAtIndex:index];
}

@end
