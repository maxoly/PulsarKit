//
//  PLKFixedSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKFixedSize.h"

#import "PLKCell.h"

typedef NS_ENUM(NSInteger, PLKFixedSizeType) {
    PLKFixedSizeTypeWidth,
    PLKFixedSizeTypeHeight,
    PLKFixedSizeTypeSize
};

@interface PLKFixedSize ()

@property (nonatomic, readwrite, assign) CGSize size;
@property (nonatomic, readwrite, assign) PLKFixedSizeType type;

@end

@implementation PLKFixedSize

#pragma mark - PLKSizeStrategy

- (CGSize)sizeForModel:(id)model withCell:(UIView<PLKCell> *)cell inContainer:(UIScrollView *)container {
    if ([cell conformsToProtocol:@protocol(PLKCell)]) {
        if ([cell respondsToSelector:@selector(prepareForLayoutWithModel:inBounds:)]) {
            [cell prepareForLayoutWithModel:model inBounds:container.bounds];
        }
    }
    
    CGSize size = CGSizeZero;
    
    switch (self.type) {
        case PLKFixedSizeTypeHeight:
            size.width = CGRectGetWidth(container.bounds);
            size.height = self.size.height;
            break;
            
        case PLKFixedSizeTypeWidth:
            size.height = CGRectGetHeight(container.bounds);
            size.width = self.size.width;
            break;
            
        case PLKFixedSizeTypeSize:
            size = self.size;
            break;
    }
    
    return size;
}

#pragma mark - Convenient Constructors

+ (instancetype)fixedWidth:(CGFloat)width {
    return [self fixedSize:CGSizeMake(width, CGFLOAT_MIN) type:PLKFixedSizeTypeWidth];
}

+ (instancetype)fixedHeight:(CGFloat)height {
    return [self fixedSize:CGSizeMake(CGFLOAT_MIN, height) type:PLKFixedSizeTypeHeight];
}

+ (instancetype)fixedSize:(CGSize)size {
    return [self fixedSize:size type:PLKFixedSizeTypeSize];
}

+ (instancetype)fixedSize:(CGSize)size type:(PLKFixedSizeType)type {
    PLKFixedSize *fixedSize = [[self alloc] init];
    fixedSize.size = size;
    fixedSize.type = type;
    return fixedSize;
}

@end
