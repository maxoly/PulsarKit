//
//  PLKAutolayoutSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKAutolayoutSize.h"

#import "NSObject+PulsarKit.h"

#import "PLKCell.h"
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

- (CGSize)sizeForEntity:(id)entity inContainer:(UIScrollView *)container atIndexPath:(NSIndexPath *)indexPath builder:(id<PLKCellBuilder>)builder {
    NSString *key = [NSString stringWithFormat:@"%@.%zd", [builder.cellClass plk_className], [entity hash]];
    
    if (self.isCacheEnabled) {
        NSValue *size = [self.sizeCache objectForKey:key];

        if (size) {
            return [size CGSizeValue];
        }
    }
    
    CGRect bounds = container.bounds;

    UIView<PLKCell> *cell = [builder cachedCellForEntity:entity inContainer:container atIndexPath:indexPath];
    [cell setFrame:bounds];
    [cell setBounds:bounds];
    
    if ([cell conformsToProtocol:@protocol(PLKCell)]) {
        if ([cell respondsToSelector:@selector(configureWithEntity:)]) {
            [cell configureWithEntity:entity];
        }

        if ([cell respondsToSelector:@selector(configureForLayoutInBounds:)]) {
            [cell configureForLayoutInBounds:bounds];
        }
    }

    [cell setNeedsUpdateConstraints];
    [cell layoutIfNeeded];
    
    CGSize cellSize = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
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
    PLKAutolayoutSize *strategy = [[PLKAutolayoutSize alloc] init];
    strategy.cacheEnabled = cacheEnabled;
    return strategy;
}


@end
