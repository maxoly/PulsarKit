//
//  PLKAutolayoutSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKAutolayoutSize.h"

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
    NSValue *size = [self.sizeCache objectForKey:entity];

    if (size) {
        return [size CGSizeValue];
    }

    CGRect bounds = container.bounds;

    UIView<PLKCell> *cell = [builder cachedCellForEntity:entity inContainer:container atIndexPath:indexPath];
    [cell setFrame:bounds];
    [cell setBounds:bounds];
    [cell configureWithEntity:entity];

    if ([cell respondsToSelector:@selector(configureForLayoutInBounds:)]) {
        [cell configureForLayoutInBounds:bounds];
    }

    CGSize cellSize = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize finalSize = CGSizeMake(CGRectGetWidth(bounds), cellSize.height);

    [self.sizeCache setObject:[NSValue valueWithCGSize:finalSize] forKey:entity];

    return finalSize;
}

@end
