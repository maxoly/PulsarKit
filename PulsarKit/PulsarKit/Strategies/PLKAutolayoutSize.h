//
//  PLKAutolayoutSize.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKSizeStrategy.h"

@interface PLKAutolayoutSize : NSObject <PLKSizeStrategy>

@property (nonatomic, readwrite, assign, getter=isCacheEnabled) BOOL cacheEnabled;
@property (nonatomic, readwrite, assign, getter=isAutolayoutWidthEnabled) BOOL autolayoutWidthEnabled;

+ (instancetype)autolayoutSize;
+ (instancetype)autolayoutSizeAndCacheEnabled:(BOOL)cacheEnabled;
+ (instancetype)autolayoutSizeAndCacheEnabled:(BOOL)cacheEnabled autolayoutWidthEnabled:(BOOL)autolayoutWidthEnabled;
+ (instancetype)autolayoutAndSizeForWidth:(id<PLKSizeStrategy>)sizeForWidth;
+ (instancetype)autolayoutAndSizeForHeight:(id<PLKSizeStrategy>)sizeForHeight;

@end
