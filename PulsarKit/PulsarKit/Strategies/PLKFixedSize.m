//
//  PLKFixedSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKFixedSize.h"

#import "PLKCell.h"

@interface PLKFixedSize ()

@property (nonatomic, readwrite, assign) CGSize size;

@end

@implementation PLKFixedSize

- (CGSize)sizeForModel:(id)model withCell:(UIView<PLKCell> *)cell inContainer:(UIScrollView *)container {
    if ([cell conformsToProtocol:@protocol(PLKCell)]) {
        if ([cell respondsToSelector:@selector(prepareForLayoutWithModel:inBounds:)]) {
            [cell prepareForLayoutWithModel:model inBounds:container.bounds];
        }
    }
    
    if (self.size.width == CGFLOAT_MIN) {
        CGSize size = self.size;
        size.width = CGRectGetWidth(container.bounds);
        self.size = size;
    }
    
    if (self.size.height == CGFLOAT_MIN) {
        CGSize size = self.size;
        size.height = CGRectGetHeight(container.bounds);
        self.size = size;
    }
    
    return self.size;
}

+ (instancetype)fixedSize:(CGSize)size {
    PLKFixedSize *fixedSize = [[PLKFixedSize alloc] init];
    fixedSize.size = size;
    return fixedSize;
}

+ (instancetype)fixedWidth:(CGFloat)width {
    return [self fixedSize:CGSizeMake(width, CGFLOAT_MIN)];
}

+ (instancetype)fixedHeight:(CGFloat)height {
    return [self fixedSize:CGSizeMake(CGFLOAT_MIN, height)];
}

@end
