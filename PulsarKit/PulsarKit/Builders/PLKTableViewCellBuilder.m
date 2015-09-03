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
#import "UITableViewCell+PulsarKit.h"


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

#pragma mark - PLKCellBuilder

- (UIView<PLKCell> *)cellForModel:(id)model withCellClass:(Class)cellClass inContainer:(UITableView *)container atIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<PLKCell> *cell = [container dequeueReusableCellWithIdentifier:[cellClass plk_className] forIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(configureWithModel:)]) {
        [cell configureWithModel:model];
    }
    return cell;
}

- (UIView<PLKCell> *)cachedCellForModel:(id)model withCellClass:(Class)cellClass inContainer:(UITableView *)container atIndexPath:(NSIndexPath *) indexPath {
    UIView<PLKCell> *cell = [self.cellCache objectForKey:[cellClass plk_className]];

    if (!cell) {
        cell = [cellClass plk_viewFromNibOrClass];
        [self.cellCache setObject:cell forKey:[cellClass plk_className]];
    }

    return cell;
}

@end
