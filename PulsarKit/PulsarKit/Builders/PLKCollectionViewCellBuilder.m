//
//  PLKCollectionViewCellBuilder.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/08/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCollectionViewCellBuilder.h"

#import "PLKCell.h"
#import "UIView+PulsarKit.h"
#import "NSObject+PulsarKit.h"



@interface PLKCollectionViewCellBuilder ()

@property (nonatomic, readwrite, strong) NSCache *cellCache;

@end



@implementation PLKCollectionViewCellBuilder

- (NSCache *)cellCache {
    if (!_cellCache) {
        _cellCache = [[NSCache alloc] init];
    }
    
    return _cellCache;
}

- (UIView<PLKCell> *)cellForEntity:(id)entity inContainer:(UICollectionView *)container atIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<PLKCell> *cell = [container dequeueReusableCellWithReuseIdentifier:[self.cellClass plk_className] forIndexPath:indexPath];
    [cell configureWithEntity:entity];
    return cell;
}

- (UIView<PLKCell> *)cachedCellForEntity:(id)entity inContainer:(UIScrollView *)container atIndexPath:(NSIndexPath *)indexPath {
    UIView<PLKCell> *cell = [self.cellCache objectForKey:[self.cellClass plk_className]];
    
    if (!cell) {
        cell = [self.cellClass plk_viewFromNibOrClass];
        [self.cellCache setObject:cell forKey:[self.cellClass plk_className]];
    }
    
    return cell;
}

+ (instancetype)builderWithCellClass:(Class)cellClass {
    PLKCollectionViewCellBuilder *builder = [[self alloc] init];
    builder.cellClass = cellClass;
    return builder;
}

@end
