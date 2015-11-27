//
//  PLKAutolayoutSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKAutolayoutSize.h"

#import "NSObject+PulsarKit.h"

#import "PLKView.h"
#import "PLKSource.h"
#import "PLKCellBuilder.h"

@interface PLKAutolayoutSize ()

@property (nonatomic, readwrite, strong) NSCache *sizeCache;

@end

@implementation PLKAutolayoutSize

- (NSCache *)sizeCache {
    if (!_sizeCache) {
        _sizeCache = [[NSCache alloc] init];
    }

    return _sizeCache;
}

- (CGSize)sizeForModel:(id)model withCellBuilder:(PLKCellBuilder *)cellBuilder forSource:(id<PLKSource>)source {
    UIScrollView *container = source.container;
    UIView<PLKView> *view = [cellBuilder build];
    
    NSString *key = [NSString stringWithFormat:@"%@.{%@}.%zd", [view plk_className], NSStringFromCGSize(container.frame.size) ,[model hash]];
    
    if (self.isCacheEnabled) {
        NSValue *size = [self.sizeCache objectForKey:key];

        if (size) {
            return [size CGSizeValue];
        }
    }
    
    CGRect bounds = container.bounds;

    
    [view setFrame:bounds];
    [view setBounds:bounds];
    
    if ([view conformsToProtocol:@protocol(PLKView)]) {
        if ([view respondsToSelector:@selector(prepareForLayoutWithModel:inBounds:)]) {
            [view prepareForLayoutWithModel:model inBounds:bounds];
        }
    }

    [view setNeedsUpdateConstraints];
    [view layoutIfNeeded];
    
    
    CGSize cellSize;
    if ([view isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *tableCell = (UITableViewCell *)view;
        cellSize = [tableCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    } else {
        cellSize = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    }
    
    CGSize finalSize = CGSizeMake(CGRectGetWidth(bounds), cellSize.height);

    if (self.isCacheEnabled) {
        [self.sizeCache setObject:[NSValue valueWithCGSize:finalSize] forKey:key];
    }

    return finalSize;
}

#pragma mark - Convenient Constructors

+ (instancetype)autolayoutSize {
    return [self autolayoutSizeAndCacheEnabled:YES];
}

+ (instancetype)autolayoutSizeAndCacheEnabled:(BOOL)cacheEnabled {
    PLKAutolayoutSize *strategy = [[self alloc] init];
    strategy.cacheEnabled = cacheEnabled;
    return strategy;
}


@end
