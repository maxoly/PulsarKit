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
    Class cellClass = cellBuilder.cellClass;
    
    if ([cellClass resolveClassMethod:@selector(cellSizeWithModel:inBounds:)]) {
        return [cellClass cellSizeWithModel:model inBounds:container.bounds];
    }
    
    return CGSizeZero;
}

#pragma mark - Convenient Constructors

+ (instancetype)size {
    return [[self alloc] init];
}

@end
