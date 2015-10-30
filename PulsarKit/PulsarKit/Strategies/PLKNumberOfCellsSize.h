//
//  PLKNumberOfCellsSize.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 30/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKSizeStrategy.h"

@interface PLKNumberOfCellsSize : NSObject <PLKSizeStrategy>

+ (instancetype)numberOfCellsForWidthAndFixedHeight:(CGFloat)height;
+ (instancetype)numberOfCellsForHeightAndFixedWidth:(CGFloat)width;

@end
