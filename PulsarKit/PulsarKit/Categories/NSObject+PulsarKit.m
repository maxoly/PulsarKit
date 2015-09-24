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
    NSString *className = NSStringFromClass(self.class);
    if ([className containsString:@"."]) {
        NSRange range = [className rangeOfString:@"." options:NSCaseInsensitiveSearch];
        className = [className substringFromIndex:(range.location + range.length)];
    }
    return className;
}

@end
