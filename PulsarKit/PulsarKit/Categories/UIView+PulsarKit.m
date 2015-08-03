//
//  UIView+PulsarKit.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "UIView+PulsarKit.h"

#import "NSObject+PulsarKit.h"

@implementation UIView (PulsarKit)

+ (instancetype)plk_viewFromNibOrClass {
    NSString *nibPath = [[NSBundle bundleForClass:self] pathForResource:[self plk_className] ofType:@"nib"];

    if (nibPath) {
        return [self plk_viewFromNib];
    } else {
        return [[self alloc] init];
    }
}

+ (instancetype)plk_viewFromNib {
    NSArray *views = [[NSBundle bundleForClass:[self class]] loadNibNamed:[self plk_className] owner:nil options:nil];
    return [views firstObject];
}

+ (UINib *)plk_nibFromClassName {
    return [UINib nibWithNibName:[self plk_className] bundle:nil];
}

@end
