//
//  NSObject+PulsarKit.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "NSObject+PulsarKit.h"

@implementation NSObject (PulsarKit)

- (NSString *)plk_className {
    return NSStringFromClass([self class]);
}

@end
