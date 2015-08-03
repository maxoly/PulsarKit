//
//  PLKTableViewCellBuilder.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKTableViewCellBuilder.h"

#import "PLKCell.h"
#import "UIView+PulsarKit.h"
#import "NSObject+PulsarKit.h"


@interface PLKTableViewCellBuilder ()

@property (nonatomic, readwrite, strong) NSCache *cellCache;

@end


@implementation PLKTableViewCellBuilder

- (NSCache *)cellCache {
    if (!_cellCache) {
        _cellCache = [[NSCache alloc] init];
    }

    return _cellCache;
}

- (UIView<PLKCell> *)cellForEntity:(id)entity inContainer:(UITableView *)container atIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<PLKCell> *cell = [container dequeueReusableCellWithIdentifier:[self.cellClass plk_className]];
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
    PLKTableViewCellBuilder *builder = [[self alloc] init];
    builder.cellClass = cellClass;
    return builder;
}

@end
