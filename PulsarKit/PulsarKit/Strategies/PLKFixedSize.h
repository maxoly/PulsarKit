//
//  PLKFixedSize.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKSizeStrategy.h"

@interface PLKFixedSize : NSObject <PLKSizeStrategy>

+ (instancetype)fixedSize:(CGSize)size;

@end
