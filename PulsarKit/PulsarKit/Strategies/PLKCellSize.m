//
//  PLKCellSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 16/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKCellSize.h"

#import "PLKView.h"
#import "PLKSource.h"
#import "PLKCellBuilder.h"

@implementation PLKCellSize

#pragma mark - PLKSizeStrategy

- (CGSize)sizeForModel:(id)model withCellBuilder:(PLKCellBuilder *)cellBuilder forSource:(id<PLKSource>)source {
    UIScrollView *container = source.container;
    UIView<PLKView> *view = [cellBuilder build];
    
    if ([view conformsToProtocol:@protocol(PLKView)]) {
        if ([view respondsToSelector:@selector(prepareForLayoutWithModel:inBounds:)]) {
            [view prepareForLayoutWithModel:model inBounds:container.bounds];
        }
    }
    
    if ([view respondsToSelector:@selector(cellSize)]) {
        return [view cellSize];
    }
    
    if ([[view class] resolveClassMethod:@selector(cellSize)]) {
        return [[view class] cellSize];
    }
    
    return CGSizeZero;
}

#pragma mark - Convenient Constructors

+ (instancetype)size {
    return [[self alloc] init];
}

@end
