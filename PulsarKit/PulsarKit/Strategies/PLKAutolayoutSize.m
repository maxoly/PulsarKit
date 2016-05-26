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
@property (nonatomic, readwrite, strong) id<PLKSizeStrategy> sizeForWidth;
@property (nonatomic, readwrite, strong) id<PLKSizeStrategy> sizeForHeight;

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
    bounds = UIEdgeInsetsInsetRect(bounds, source.containerInset);
    
    if (self.sizeForWidth) {
        CGSize size = [self.sizeForWidth sizeForModel:model withCellBuilder:cellBuilder forSource:source];
        bounds.size.width = size.width;
    }
    
    if (self.sizeForHeight) {
        CGSize size = [self.sizeForHeight sizeForModel:model withCellBuilder:cellBuilder forSource:source];
        bounds.size.height = size.height;
    }
    
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
    
    CGFloat width = cellSize.width;
    if (!self.isAutolayoutWidthEnabled) {
        width = CGRectGetWidth(bounds);
    }
    
    CGSize finalSize = CGSizeMake(width, cellSize.height);
    
    if (self.sizeForWidth) {
        CGSize size = [self.sizeForWidth sizeForModel:model withCellBuilder:cellBuilder forSource:source];
        finalSize.width = size.width;
    }
    
    if (self.sizeForHeight) {
        CGSize size = [self.sizeForHeight sizeForModel:model withCellBuilder:cellBuilder forSource:source];
        finalSize.height = size.height;
    }

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
    return [self autolayoutSizeAndCacheEnabled:cacheEnabled autolayoutWidthEnabled:NO];
}

+ (instancetype)autolayoutSizeAndCacheEnabled:(BOOL)cacheEnabled autolayoutWidthEnabled:(BOOL)autolayoutWidthEnabled {
    PLKAutolayoutSize *strategy = [[self alloc] init];
    strategy.cacheEnabled = cacheEnabled;
    strategy.autolayoutWidthEnabled = autolayoutWidthEnabled;
    return strategy;
}

+ (instancetype)autolayoutAndSizeForWidth:(id<PLKSizeStrategy>)sizeForWidth {
    PLKAutolayoutSize *size = [self autolayoutSizeAndCacheEnabled:YES];
    size.sizeForWidth = sizeForWidth;
    return size;
}

+ (instancetype)autolayoutAndSizeForHeight:(id<PLKSizeStrategy>)sizeForHeight {
    PLKAutolayoutSize *size = [self autolayoutSizeAndCacheEnabled:YES];
    size.sizeForHeight = sizeForHeight;
    return size;
}

@end
