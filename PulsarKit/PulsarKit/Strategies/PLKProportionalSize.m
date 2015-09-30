//
//  PLKProportionalSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKProportionalSize.h"


typedef NS_ENUM(NSUInteger, PLKProportionalType) {
    PLKProportionalSame,
    PLKProportionalWidthBasedOnHeight,
    PLKProportionalWidthBasedOnContainerWidth,
    PLKProportionalHeightBasedOnWidth,
    PLKProportionalHeightBasedOnContainerHeight
};



@interface PLKProportionalSize ()

@property (nonatomic,readwrite, assign) CGFloat height;
@property (nonatomic,readwrite, assign) CGFloat width;
@property (nonatomic,readwrite, assign) PLKProportionalType type;

@end



@implementation PLKProportionalSize

#pragma mark - PLKSizeStrategy

- (CGSize)sizeForModel:(id)model withView:(UIView<PLKView> *)cell inContainer:(UIScrollView *)container {
    CGFloat width = 0;
    CGFloat height = 0;
    
    switch (self.type) {
        case PLKProportionalSame:
            width = CGRectGetWidth(container.frame) * self.ratio;
            height = CGRectGetHeight(container.frame) * self.ratio;
            
        case PLKProportionalWidthBasedOnHeight:
            width = CGRectGetHeight(container.frame) * self.ratio;
            height = CGRectGetHeight(container.frame);
        
        case PLKProportionalWidthBasedOnContainerWidth:
            width = CGRectGetWidth(container.frame) * self.ratio;
            height = self.height;
            break;
            
        case PLKProportionalHeightBasedOnWidth:
            width = CGRectGetWidth(container.frame);
            height = CGRectGetWidth(container.frame) * self.ratio;
            break;
            
        case PLKProportionalHeightBasedOnContainerHeight:
            width = self.width;
            height = CGRectGetHeight(container.frame) * self.ratio;
            break;
    }
    
    return CGSizeMake(width, height);
}

    

#pragma mark - Convenient Constructors

+ (instancetype)proportionalSame:(CGFloat)ratio {
    PLKProportionalSize *strategy = [[self alloc] init];
    strategy.type = PLKProportionalSame;
    strategy.ratio = ratio;
    return strategy;
}

+ (instancetype)proportionalHeightBasedOnWidth:(CGFloat)ratio {
    PLKProportionalSize *strategy = [[self alloc] init];
    strategy.ratio = ratio;
    strategy.type = PLKProportionalHeightBasedOnWidth;
    return strategy;
}

+ (instancetype)proportionalHeightBasedOnContainerHeight:(CGFloat)ratio fixedWidth:(CGFloat)width {
    PLKProportionalSize *strategy = [[self alloc] init];
    strategy.ratio = ratio;
    strategy.width = width;
    strategy.type = PLKProportionalHeightBasedOnContainerHeight;
    return strategy;
}

+ (instancetype)proportionalWidthBasedOnHeight:(CGFloat)ratio {
    PLKProportionalSize *strategy = [[self alloc] init];
    strategy.ratio = ratio;
    strategy.type = PLKProportionalWidthBasedOnHeight;
    return strategy;
    
}

+ (instancetype)proportionalWidthBasedOnContainerWidth:(CGFloat)ratio fixedHeight:(CGFloat)height {
    PLKProportionalSize *strategy = [[self alloc] init];
    strategy.ratio = ratio;
    strategy.height = height;
    strategy.type = PLKProportionalWidthBasedOnContainerWidth;
    return strategy;
}

@end
