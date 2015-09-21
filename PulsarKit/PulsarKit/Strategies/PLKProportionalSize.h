//
//  PLKProportionalSize.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKSizeStrategy.h"

@interface PLKProportionalSize : NSObject<PLKSizeStrategy>

@property (nonatomic,readwrite, assign) CGFloat ratio;

+ (instancetype)proportionalSame:(CGFloat)ratio;
+ (instancetype)proportionalHeightBasedOnWidth:(CGFloat)ratio;
+ (instancetype)proportionalHeightBasedOnContainerHeight:(CGFloat)ratio fixedWidth:(CGFloat)width;
+ (instancetype)proportionalWidthBasedOnHeight:(CGFloat)ratio;
+ (instancetype)proportionalWidthBasedOnContainerWidth:(CGFloat)ratio fixedHeight:(CGFloat)height;

@end
