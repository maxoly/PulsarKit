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

+ (instancetype)autolayoutSize;
+ (instancetype)autolayoutSizeAndCacheEnabled:(BOOL)cacheEnabled;

@end
