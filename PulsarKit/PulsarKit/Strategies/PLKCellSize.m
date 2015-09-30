//
//  PLKCellSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 16/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKCellSize.h"

#import "PLKView.h"

@implementation PLKCellSize

#pragma mark - PLKSizeStrategy

- (CGSize)sizeForModel:(id)model withView:(UIView<PLKView> *)cell inContainer:(UIScrollView *)container {
    if ([cell conformsToProtocol:@protocol(PLKView)]) {
        if ([cell respondsToSelector:@selector(prepareForLayoutWithModel:inBounds:)]) {
            [cell prepareForLayoutWithModel:model inBounds:container.bounds];
        }
    }
    
    if ([cell respondsToSelector:@selector(cellSize)]) {
        return [cell cellSize];
    }
    
    if ([[cell class] resolveClassMethod:@selector(cellSize)]) {
        return [[cell class] cellSize];
    }
    
    return CGSizeZero;
}

#pragma mark - Convenient Constructors

+ (instancetype)size {
    return [[self alloc] init];
}

@end
